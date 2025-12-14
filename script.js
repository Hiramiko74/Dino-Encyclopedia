// --- STATE MANAGEMENT ---
let state = {
    dinos: [],
    tags: { families: [], periods: [], formations: [] },
    isPegawai: false,
    activeTab: 'dino_data',
    sortBy: 'name',
    sortDir: 1,
    filters: { diet: '', period: '', family: '', formation: '' },
    pubFilters: { diet: '', period: '', family: '' },
    pubSortBy: 'name',
    pubSortDir: 1
};

let pendingDelete = null; 

// --- INIT ---
document.addEventListener('DOMContentLoaded', () => {
    loadData();
    setupEventListeners();
});

// --- CORE FUNCTIONS ---
async function loadData() {
    try {
        console.log("Mengambil data dari MySQL...");
        const response = await fetch('api/get_data.php');
        
        if (!response.ok) throw new Error("Gagal koneksi API");
        
        const data = await response.json();
        
        // Update State
        state.dinos = data.dinos || [];
        state.tags = data.tags || { families: [], periods: [], formations: [] };

        console.log(`Sukses! ${state.dinos.length} dinosaurus dimuat.`);
        renderApp(); 
    } catch (error) {
        console.error("Error:", error);
        showToast("Gagal koneksi Database (Pastikan XAMPP Nyala)", "error");
    }
}

function saveDataAll() {
    console.log("Simpan ke Database belum aktif. Perubahan hanya sementara di layar.");
}

function showToast(msg, type = 'success') {
    const toast = document.getElementById('status-toast');
    if (!toast) return;
    toast.textContent = msg;
    toast.style.backgroundColor = type === 'error' ? '#c62828' : '#2e7d32'; 
    toast.className = type;
    toast.style.display = 'block';
    setTimeout(() => { toast.style.display = 'none'; }, 3000);
}

function getDietBadge(diet) {
    if (!diet) return '';
    let cssClass = 'diet-other';
    const d = diet.toLowerCase();
    if (d === 'karnivora') cssClass = 'diet-karnivora';
    else if (d === 'herbivora') cssClass = 'diet-herbivora';
    else if (d === 'omnivora') cssClass = 'diet-omnivora';
    return `<span class="badge-diet ${cssClass}">${diet}</span>`;
}

// --- RENDERING MAIN ---
function renderApp() {
    const viewerUI = document.getElementById('viewer-ui');
    const adminUI = document.getElementById('admin-ui');
    
    // Toggle Tampilan Admin / Viewer
    if (state.isPegawai) {
        viewerUI.classList.add('hidden');
        adminUI.classList.remove('hidden');
        renderAdmin();
    } else {
        viewerUI.classList.remove('hidden');
        adminUI.classList.add('hidden');
        renderViewer();
    }
}

// --- VIEWER LOGIC ---
function renderViewer() {
    const mapOverlay = document.getElementById('map-overlay');
    mapOverlay.innerHTML = '';

    // Render Titik Peta
    if (state.tags.formations) {
        state.tags.formations.forEach(formation => {
            const dinosInFormation = state.dinos.filter(d => d.formationName === formation.name);
            if (dinosInFormation.length === 0) return;

            const isPrimary = dinosInFormation.some(d => d.isPrimary);
            const point = document.createElement('div');
            point.className = `map-point ${isPrimary ? 'primary' : ''}`;
            point.style.left = formation.left + '%';
            point.style.top = formation.top + '%';
            point.title = `${formation.name} (${dinosInFormation.length} Spesies)`;
            point.onclick = () => showFormationModal(formation.name, dinosInFormation);
            mapOverlay.appendChild(point);
        });
    }

    renderPublicList();
    populatePublicDropdowns();
}

function renderPublicList() {
    const container = document.getElementById('public-dino-list');
    if (!container) return;

    let data = state.dinos.filter(d => {
        return (!state.pubFilters.diet || d.diet === state.pubFilters.diet) &&
               (!state.pubFilters.period || d.period === state.pubFilters.period) &&
               (!state.pubFilters.family || d.family === state.pubFilters.family);
    });

    data.sort((a, b) => {
        const valA = a[state.pubSortBy] || '';
        const valB = b[state.pubSortBy] || '';
        return valA.localeCompare(valB) * state.pubSortDir;
    });

    if (data.length === 0) {
        container.innerHTML = '<p style="grid-column:1/-1; text-align:center; color:#888; padding:20px;">Tidak ada data.</p>';
        return;
    }

    container.innerHTML = data.map(d => `
        <div class="dino-card-mini" onclick="showDinoDetail('${d.id}')">
            <div class="list-item-thumb" style="width:60px; height:60px;">
                <img src="${d.imageUrl || ''}" onerror="this.style.display='none'" style="width:100%; height:100%; object-fit:contain;">
            </div>
            <div style="flex:1; overflow:hidden;">
                <div style="font-weight:bold; color:#333; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${d.name}</div>
                <div style="font-size:0.8rem; color:#888;">${d.period}</div>
            </div>
            <div>${getDietBadge(d.diet)}</div>
        </div>
    `).join('');
}

function populatePublicDropdowns() {
    const fill = (id, items) => {
        const el = document.getElementById(id);
        if (!el || !items) return;
        const currentVal = el.value;
        
        // Ambil label default
        const label = el.options[0] ? el.options[0].text : "Semua";

        const optionsHtml = items.map(item => {
            // Jika item adalah object, maka ambil properti .name
            const val = (typeof item === 'object' && item.name) ? item.name : item;
            return `<option value="${val}">${val}</option>`;
        }).join('');
        
        el.innerHTML = `<option value="">${label}</option>` + optionsHtml;
        el.value = currentVal;
    };
    
    // Panggil fungsi fill
    fill('pubFilterDiet', ['Karnivora', 'Herbivora', 'Omnivora']);
    fill('pubFilterPeriode', state.tags.periods);
    fill('pubFilterFamily', state.tags.families);
}

window.handlePublicSort = (col) => {
    if (state.pubSortBy === col) state.pubSortDir *= -1;
    else { state.pubSortBy = col; state.pubSortDir = 1; }
    renderPublicList();
};

// --- MODAL LOGIC ---
function showDinoDetail(id) {
    const d = state.dinos.find(x => x.id === id);
    if (!d) return;
    const modalBody = document.getElementById('modal-body');
    
    const safeFamily = d.family ? d.family.replace(/'/g, "\\'") : '';
    const safeFormation = d.formationName ? d.formationName.replace(/'/g, "\\'") : '';

    modalBody.innerHTML = `
        <div class="dino-detail-layout">
            <div class="detail-left">
                <div style="background:#f9f9f9; border-radius:8px; padding:5px; margin-bottom:15px; border:1px solid #eee;">
                    <img src="${d.imageUrl || 'https://placehold.co/300x200?text=No+Image'}" style="width:100%; border-radius:6px; display:block;">
                </div>
                <h2 style="color:#5d4037; font-size:1.4rem; line-height:1.2; margin-bottom:10px;">${d.name}</h2>
                <div style="margin-bottom:15px; display:flex; gap:5px; flex-wrap:wrap; align-items:center;">
                    ${getDietBadge(d.diet)}
                    <span style="background:#f5f5f5; color:#666; padding:3px 10px; border-radius:20px; font-size:0.75rem; font-weight:bold; border:1px solid #ddd;">${d.period}</span>
                </div>
                <table class="stats-table">
                    <tr><td class="stats-label">Family</td><td class="stats-value"><span class="interactive-link" onclick="openFamilyByName('${safeFamily}')">${d.family} ➜</span></td></tr>
                    <tr><td class="stats-label">Formasi</td><td class="stats-value"><span class="interactive-link" onclick="openFormationByName('${safeFormation}')">${d.formationName} ➜</span></td></tr>
                    <tr><td class="stats-label">Tinggi</td><td class="stats-value">${d.height ? d.height + ' m' : '-'}</td></tr>
                    <tr><td class="stats-label">Panjang</td><td class="stats-value">${d.length ? d.length + ' m' : '-'}</td></tr>
                    <tr><td class="stats-label">Berat</td><td class="stats-value">${d.weight ? d.weight + ' ton' : '-'}</td></tr>
                </table>
            </div>
            <div class="detail-right">
                <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #eee; padding-bottom:10px; margin-bottom:15px;">
                    <h3 style="color:#5d4037; margin:0;">Deskripsi Spesies</h3>
                    <button onclick="document.getElementById('modal-overlay').classList.add('hidden')" style="background:none; border:none; color:#999; font-size:1.5rem; cursor:pointer;">&times;</button>
                </div>
                <div style="line-height:1.8; color:#444; text-align:justify; font-size:0.95rem;">
                    <p>${d.description || 'Belum ada deskripsi.'}</p>
                </div>
            </div>
        </div>
    `;
    document.getElementById('modal-overlay').classList.remove('hidden');
}

function showListModal(title, dinos, subtitlePrefix = "Lokasi") {
    const modalBody = document.getElementById('modal-body');
    if (dinos.length === 0) { showToast("Tidak ada data.", "error"); return; }

    const listHtml = dinos.map(d => `
        <div style="padding:10px; border-bottom:1px solid #f0f0f0; display:flex; justify-content:space-between; align-items:center; cursor:pointer;" onclick="showDinoDetail('${d.id}')">
            <div style="display:flex; align-items:center; gap:15px;">
                <div class="list-item-thumb"><img src="${d.imageUrl || ''}" onerror="this.style.display='none'"></div>
                <div><div style="font-weight:bold;">${d.name}</div><div style="font-size:0.8rem; color:#888;">${d.period}</div></div>
            </div>
            <div>${getDietBadge(d.diet)}</div>
        </div>
    `).join('');

    modalBody.innerHTML = `
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:10px;">
            <div><small style="text-transform:uppercase; color:#999;">${subtitlePrefix}</small><h2 style="color:#5d4037; margin:0;">${title}</h2></div>
            <button onclick="document.getElementById('modal-overlay').classList.add('hidden')" style="background:none; border:none; font-size:1.5rem; color:#ccc; cursor:pointer;">&times;</button>
        </div>
        <div style="max-height:400px; overflow-y:auto;">${listHtml}</div>
    `;
    document.getElementById('modal-overlay').classList.remove('hidden');
}

function openFamilyByName(familyName) { showListModal(familyName, state.dinos.filter(d => d.family === familyName), "Family"); }
function openFormationByName(formationName) { showListModal(formationName, state.dinos.filter(d => d.formationName === formationName), "Formasi Geologi"); }
function showFormationModal(name, dinos) { showListModal(name, dinos, "Formasi Geologi"); }

// --- ADMIN RENDERING ---
function renderAdmin() {
    const tabDino = document.getElementById('dino-data-view');
    const tabTag = document.getElementById('tag-manager-view');
    const btnTabDino = document.getElementById('tab-dino-data');
    const btnTabTag = document.getElementById('tab-tag-management');
    
    populateDropdowns();

    if (state.activeTab === 'dino_data') {
        tabDino.classList.remove('hidden'); tabTag.classList.add('hidden');
        btnTabDino.classList.add('active'); btnTabTag.classList.remove('active');
        renderTable();
    } else {
        tabDino.classList.add('hidden'); tabTag.classList.remove('hidden');
        btnTabTag.classList.add('active'); btnTabDino.classList.remove('active');
        renderTagManager();
    }
}

function populateDropdowns() {
    const fill = (id, items) => {
        const el = document.getElementById(id);
        if (!el || !items) return;
        const currentVal = el.value;
        
        const optionsHtml = items.map(item => {
            // Jika item adalah object, ambil properti .name
            const val = (typeof item === 'object' && item.name) ? item.name : item;
            return `<option value="${val}">${val}</option>`;
        }).join('');
        
        el.innerHTML = `<option value="">Semua/Pilih</option>` + optionsHtml;
        
        // Kembalikan value yang sedang dipilih jika ada
        if (items.some(i => (i.name || i) === currentVal)) {
            el.value = currentVal;
        }
    };

    // Filter Tabel Admin
    fill('filterDiet', ['Karnivora', 'Herbivora', 'Omnivora']);
    fill('filterPeriode', state.tags.periods);
    fill('filterFamily', state.tags.families);
    if(state.tags.formations) fill('filterFormasi', state.tags.formations);
    
    // Dropdown di Form Tambah/Edit
    fill('dinoPeriod', state.tags.periods);
    fill('dinoFamily', state.tags.families);
    if(state.tags.formations) fill('dinoFormation', state.tags.formations);
}

function renderTable() {
    const tbody = document.getElementById('table-body');
    let data = state.dinos.filter(d => {
        return (!state.filters.diet || d.diet === state.filters.diet) &&
               (!state.filters.period || d.period === state.filters.period) &&
               (!state.filters.family || d.family === state.filters.family) &&
               (!state.filters.formation || d.formationName === state.filters.formation);
    });

    data.sort((a, b) => {
        const valA = a[state.sortBy] || '';
        const valB = b[state.sortBy] || '';
        return valA.localeCompare(valB) * state.sortDir;
    });

    tbody.innerHTML = data.map(d => `
        <tr>
            <td>${d.name}</td>
            <td>${d.family}</td>
            <td>${getDietBadge(d.diet)}</td>
            <td>${d.period}</td>
            <td>${d.formationName}</td>
            <td>
                <button class="btn-edit" onclick="editDino('${d.id}')">Edit</button>
                <button class="btn-danger" onclick="deleteDino('${d.id}')">Hapus</button>
            </td>
        </tr>
    `).join('');
}

function renderTagManager() {
    const container = document.getElementById('tag-management-content');
    
    const createSection = (title, type, items) => {
        if(!items) items = [];
        const listHtml = items.map(item => {
            // item sekarang adalah Object {id, name, left, top}
            const safeName = item.name.replace(/'/g, "\\'");
            const coordInfo = (type === 'formations') ? `<small style="display:block; font-size:10px; color:#666">Pos: ${item.left}%, ${item.top}%</small>` : '';
            
            return `
            <div class="tag-item">
                <div style="flex-grow:1"><span>${item.name}</span>${coordInfo}</div>
                <div style="display:flex; gap:5px;">
                    <button class="btn-edit" onclick="openEditTagModal('${type}', '${item.id}', '${safeName}', ${item.left||0}, ${item.top||0})">Edit</button>
                    <button class="btn-danger" onclick="confirmDeleteTag('${type}', '${item.id}', '${safeName}')">X</button>
                </div>
            </div>`;
        }).join('');

        const extraInput = (type === 'formations') ? `
            <div style="display:flex; gap:5px; margin-top:5px;">
                <input type="number" id="new-${type}-x" placeholder="X%" style="width:60px">
                <input type="number" id="new-${type}-y" placeholder="Y%" style="width:60px">
            </div>` : '';

        return `
            <div class="tag-card">
                <h4>${title}</h4>
                <div style="margin-bottom:10px;">
                    <input type="text" id="new-${type}" placeholder="Tambah baru..." style="width:100%">
                    ${extraInput}
                    <button class="btn-primary" style="width:100%; margin-top:5px;" onclick="addTag('${type}')">Tambah</button>
                </div>
                <div style="max-height:200px; overflow-y:auto;">${listHtml}</div>
            </div>
        `;
    };

    container.innerHTML = 
        createSection('Families', 'families', state.tags.families) +
        createSection('Periode', 'periods', state.tags.periods) +
        createSection('Formasi', 'formations', state.tags.formations);
}

// 1. TAMBAH TAG
window.addTag = async (type) => {
    const inputId = `new-${type}`;
    const nameVal = document.getElementById(inputId).value;
    
    if (!nameVal) { showToast("Nama tidak boleh kosong!", "error"); return; }
    
    const payload = {
        type: type, // families, periods, formations
        name: nameVal,
        id: null // ID null artinya Tambah Baru
    };

    if (type === 'formations') {
        payload.x = document.getElementById(`new-${type}-x`).value || 50;
        payload.y = document.getElementById(`new-${type}-y`).value || 50;
    }

    try {
        const res = await fetch('api/save_tag.php', {
            method: 'POST', body: JSON.stringify(payload)
        });
        const result = await res.json();
        
        if(result.status === 'success') {
            showToast("Tag berhasil ditambah");
            document.getElementById(inputId).value = '';
            loadData(); // Refresh list
        } else {
            showToast(result.message, 'error');
        }
    } catch(e) { console.error(e); showToast("Gagal koneksi", "error"); }
};

// 2. HAPUS TAG
window.confirmDeleteTag = (type, id, name) => {
    pendingDelete = { type, id }; // Simpan ID untuk dihapus
    document.getElementById('confirm-msg').textContent = `Hapus "${name}"?`;
    document.getElementById('confirm-modal').classList.remove('hidden');
};

// Pasang Listener Tombol Delete di Modal Konfirmasi
document.getElementById('confirm-btn-action').onclick = async () => {
    if (!pendingDelete) return;
    try {
        const res = await fetch('api/delete_tag.php', {
            method: 'POST', body: JSON.stringify({ id: pendingDelete.id })
        });
        const result = await res.json();
        if(result.status === 'success') {
            showToast("Tag dihapus");
            loadData();
        } else {
            showToast(result.message, 'error');
        }
    } catch(e) { console.error(e); }
    
    document.getElementById('confirm-modal').classList.add('hidden');
    pendingDelete = null;
};
window.closeConfirmModal = () => { 
    document.getElementById('confirm-modal').classList.add('hidden'); pendingDelete = null; 
};

// 3. EDIT TAG
window.openEditTagModal = (type, id, oldName, oldX, oldY) => {
    document.getElementById('edit-tag-type').value = type;
    document.getElementById('edit-tag-old-val').value = id; // ID disimpan di sini
    document.getElementById('edit-tag-name').value = oldName;

    const coordDiv = document.getElementById('edit-tag-coords');
    if (type === 'formations') {
        coordDiv.classList.remove('hidden');
        document.getElementById('edit-tag-x').value = oldX;
        document.getElementById('edit-tag-y').value = oldY;
    } else {
        coordDiv.classList.add('hidden');
    }
    document.getElementById('edit-tag-modal').classList.remove('hidden');
};

window.closeEditTagModal = () => document.getElementById('edit-tag-modal').classList.add('hidden');

window.handleEditTagSubmit = async (e) => {
    e.preventDefault();
    const type = document.getElementById('edit-tag-type').value;
    const id = document.getElementById('edit-tag-old-val').value;
    const newName = document.getElementById('edit-tag-name').value;

    const payload = {
        type: type,
        id: id,
        name: newName,
        x: document.getElementById('edit-tag-x').value,
        y: document.getElementById('edit-tag-y').value
    };

    try {
        const res = await fetch('api/save_tag.php', {
            method: 'POST', body: JSON.stringify(payload)
        });
        const result = await res.json();
        
        if(result.status === 'success') {
            showToast("Perubahan disimpan");
            loadData();
            closeEditTagModal();
        } else {
            showToast(result.message, 'error');
        }
    } catch(e) { console.error(e); }
};

// --- CRUD ---
window.handleSort = (col) => {
    if (state.sortBy === col) state.sortDir *= -1; else { state.sortBy = col; state.sortDir = 1; }
    renderTable();
};

window.deleteDino = async (id) => {
    if (!confirm('Yakin ingin menghapus data ini? data yang dihapus tidak dapat dikembalikan')) return;

    try {
        const response = await fetch('api/delete_dino.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: id })
        });

        const result = await response.json();
        
        if (result.status === 'success') {
            showToast('Data berhasil dihapus');
            loadData(); // Refresh data tanpa reload page
        } else {
            showToast('Gagal menghapus: ' + result.message, 'error');
        }
    } catch (error) {
        console.error('Error:', error);
        showToast('Terjadi kesalahan server', 'error');
    }
};

window.editDino = (id) => { 
    const d = state.dinos.find(x => x.id === id); if (!d) return;
    document.getElementById('dinoId').value = d.id;
    document.getElementById('dinoName').value = d.name;
    document.getElementById('dinoImage').value = d.imageUrl || '';
    document.getElementById('dinoDiet').value = d.diet;
    document.getElementById('dinoPeriod').value = d.period;
    document.getElementById('dinoFamily').value = d.family;
    document.getElementById('dinoFormation').value = d.formationName;
    document.getElementById('dinoHeight').value = d.height || '';
    document.getElementById('dinoLength').value = d.length || '';
    document.getElementById('dinoWeight').value = d.weight || '';
    document.getElementById('dinoPrimary').checked = d.isPrimary;
    document.getElementById('dinoDescription').value = d.description || '';
    document.getElementById('admin-form-container').classList.remove('hidden');
};

// --- EVENT LISTENERS ---
function setupEventListeners() {
    // 1. Toggle Mode Admin
    const pegMode = document.getElementById('pegawai-mode-toggle');
    if(pegMode) {
        pegMode.addEventListener('change', (e) => { 
            state.isPegawai = e.target.checked; 
            renderApp(); 
        });
    }

    // 2. Daftar Dinosaurus Foldable
    const accHeader = document.getElementById('public-list-toggle');
    if(accHeader) {
        accHeader.onclick = () => {
            const content = document.getElementById('public-list-content');
            content.classList.toggle('show');
            accHeader.classList.toggle('accordion-open');
        };
    }

    // 3. Tab Admin
    const t1 = document.getElementById('tab-dino-data'); const t2 = document.getElementById('tab-tag-management');
    if(t1) t1.onclick = () => { state.activeTab = 'dino_data'; renderAdmin(); };
    if(t2) t2.onclick = () => { state.activeTab = 'tag_management'; renderAdmin(); };

    // 4. Tombol Form & Modal
    const showBtn = document.getElementById('show-form-btn');
    if(showBtn) showBtn.onclick = () => { document.getElementById('admin-form').reset(); document.getElementById('dinoId').value = ''; document.getElementById('admin-form-container').classList.remove('hidden'); };
    
    const closeForm = document.getElementById('close-form-btn'); 
    if(closeForm) closeForm.onclick = () => document.getElementById('admin-form-container').classList.add('hidden');
    
    const closeMod = document.getElementById('close-modal');
    if(closeMod) closeMod.onclick = () => document.getElementById('modal-overlay').classList.add('hidden');

    // 5. Filter Dropdown
    ['filterDiet', 'filterPeriode', 'filterFamily', 'filterFormasi'].forEach(id => {
        const el = document.getElementById(id);
        if(el) el.addEventListener('change', (e) => {
            const key = id.replace('filter', '').toLowerCase();
            const realKey = key === 'periode' ? 'period' : key;
            state.filters[realKey] = e.target.value; renderTable();
        });
    });

    ['pubFilterDiet', 'pubFilterPeriode', 'pubFilterFamily'].forEach(id => {
        const el = document.getElementById(id);
        if(el) el.addEventListener('change', (e) => {
            const key = id.replace('pubFilter', '').toLowerCase();
            const realKey = key === 'periode' ? 'period' : key;
            state.pubFilters[realKey] = e.target.value; renderPublicList();
        });
    });
}

// --- FORM SUBMISSION ---
document.addEventListener('DOMContentLoaded', () => {
    const adminForm = document.getElementById('admin-form');
    
    if (adminForm) {
        adminForm.onsubmit = async (e) => {
            e.preventDefault();
            
            // Ambil nilai dari input form
            const idRaw = document.getElementById('dinoId').value;
            // Jika ID kosong (Add New), pakai timestamp. Jika ada (Edit), pakai ID lama.
            const id = idRaw || Date.now().toString();

            const newData = {
                id: id,
                name: document.getElementById('dinoName').value,
                imageUrl: document.getElementById('dinoImage').value,
                diet: document.getElementById('dinoDiet').value,
                period: document.getElementById('dinoPeriod').value,
                family: document.getElementById('dinoFamily').value,
                formationName: document.getElementById('dinoFormation').value,
                height: document.getElementById('dinoHeight').value,
                length: document.getElementById('dinoLength').value,
                weight: document.getElementById('dinoWeight').value,
                isPrimary: document.getElementById('dinoPrimary').checked,
                description: document.getElementById('dinoDescription').value
            };

            try {
                // Kirim data ke PHP
                const response = await fetch('api/save_dino.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(newData)
                });

                const result = await response.json();

                if (result.status === 'success') {
                    showToast('Sukses! Data disimpan ke Database.');
                    document.getElementById('admin-form-container').classList.add('hidden');
                    adminForm.reset(); // Kosongkan form
                    document.getElementById('dinoId').value = '';
                    loadData(); // Refresh tampilan otomatis
                } else {
                    showToast('Gagal menyimpan: ' + (result.message || 'Error'), 'error');
                }
            } catch (error) {
                console.error('Error:', error);
                showToast('Gagal koneksi ke server', 'error');
            }
        };
    }
});