-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Des 2025 pada 12.10
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dino_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dinos`
--

CREATE TABLE `dinos` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `diet` varchar(50) DEFAULT NULL,
  `period` varchar(100) DEFAULT NULL,
  `family` varchar(100) DEFAULT NULL,
  `formation_name` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `height` float DEFAULT 0,
  `length` float DEFAULT 0,
  `weight` float DEFAULT 0,
  `is_primary` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dinos`
--

INSERT INTO `dinos` (`id`, `name`, `description`, `diet`, `period`, `family`, `formation_name`, `image_url`, `height`, `length`, `weight`, `is_primary`) VALUES
('1', 'Tyrannosaurus Rex', 'Tyrannosaurus adalah salah satu teropoda besar yang paling dikenal oleh khalayak luas. Tyrannosaurus hidup di sebuah benua yang dikenal dengan nama Laramidia, yang kini telah berubah menjadi Amerika Utara bagian barat. yrannosaurus adalah seekor karnivora bipedal dengan tengkorak besar yang diseimbangkan oleh ekornya yang berat dan panjang. Tyrannosaurus memiliki tungkai belakang yang kuat dan besar, sementara tungkai depannya pendek dan hanya memiliki dua jari.', 'Karnivora', 'Cretaceous Akhir', 'Tyrannosauridae', 'Formasi Hell\'s Creek', 'https://upload.wikimedia.org/wikipedia/commons/0/09/Tyrannosaurus-rex-Profile-steveoc86.png', 4, 13, 8.8, 1),
('1765651060190', 'Allosaurus Fragilis', 'Allosaurus merupakan dinosaurus karnivor terbesar dalam Periode Jurasik. Allosaurus merupakan salah satu jenis dinosaurus yang paling baik dikenal sejauh ini selain karnivor terdahulu lainnya seperti Megalosaurus dan Tyrannosaurus rex.', 'Karnivora', 'Jurassic Akhir', 'Allosauridae', 'Formasi Morrison', 'https://upload.wikimedia.org/wikipedia/commons/3/3d/Allosaurus_Revised.jpg', 4.5, 8.5, 1.7, 1),
('1765651635715', 'Saurophaganax', 'Saurophaganax adalah genus dinosaurus besar dari famili Allosauridae dari Formasi Morrison dari kala Jura Akhir (sub-kala Kimmeridgium akhir, sekitar 151 juta tahun yang lalu) di Oklahoma, Amerika Serikat. Saurophaganax merepresentasikan Allosauridae Morrison yang sangat besar yang dikarakterisasikan oleh laminae horisontal pada dasar tulang belakang syaraf dorsal diatas proses transversi', 'Karnivora', 'Jurassic Akhir', 'Allosauridae', 'Formasi Morrison', 'https://cdn.shopify.com/s/files/1/0274/6014/1133/files/Saurophaganax_black_Kevin_-_Edited_480x480.png?v=1666797022', 4, 11, 3, 0),
('1765655481079', 'Alioramus Altai', 'Alioramus adalah sebuah genus dinosaurus theropoda tyrannosaurid yang berasal dari periode Kapur Akhir di Asia. Hubungannya dengan genera tyrannosaurid lainnya awalnya masih belum jelas, dengan beberapa bukti mendukung hipotesis bahwa genus ini berkerabat dekat dengan spesies kontemporer Tarbosaurus bataar. Namun, penemuan Qianzhousaurus mengindikasikan bahwa genus ini masuk kedalam cabang tyrannosaurus yang berbeda, yaitu tribus Alioramini.', 'Karnivora', 'Cretaceous Akhir', 'Tyrannosauridae', 'Formasi Nemegt', 'https://www.thoughtco.com/thmb/2ULFt8EOdtzeU18Eg71_OkgF9KU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/alioramusFW-58b9a9ef5f9b58af5c8cc099.jpg', 2.2, 6, 0.7, 1),
('1765655672267', 'Tarbosaurus Bataar', 'Tarbosaurus adalah sebuah genus dinosaurus teropoda yang tergolong ke dalam famili Tyrannosauridae. Mereka hidup di Asia sekitar 70 juta tahun yang lalu pada akhir zaman Kapur. Tarbosaurus hidup di dataran banjir yang lembap yang dilintasi oleh sungai-sungai. Di habitat ini, hewan tersebut adalah predator puncak yang mungkin memburu dinosaurus-dinosaurus besar seperti hadrosaurus Saurolophus atau sauropoda Nemegtosaurus.', 'Karnivora', 'Cretaceous Akhir', 'Tyrannosauridae', 'Formasi Nemegt', 'https://upload.wikimedia.org/wikipedia/commons/8/8b/Tarbosaurus_baatar_paleoart_%282024%29.png', 3, 10, 4.5, 1),
('1765656007939', 'Diplodocus', 'Diplodocus adalah genus dinosaurus sauropod diplodocid yang fosilnya pertama kali ditemukan pada tahun 1877 oleh S. W. Williston. Diplodocus mungkin termasuk dalam sepuluh dinosaurus terbesar, dengan panjang 31 m. Tingginya sekitar 5 m, terhitung pendek bagi Sauropoda kebanyakan. Berat sekitar 20 ton yang terhitung ringan karena tulang-tulangnya berrongga.', 'Herbivora', 'Jurassic Akhir', 'Diplodocidae', 'Formasi Morrison', 'https://upload.wikimedia.org/wikipedia/commons/0/08/Diplodocus_carnegii.jpg', 4, 24, 10, 1),
('1765657434479', 'Spinosaurus', 'Spinosaurus merupakan dinosaurus terbesar dari anggota Spinosauridae. Spinosaurus juga merupakan satu dari tiga Theropoda terbesar sepanjang masa, yang hidup di daerah yang kini bisa dikenali sebagai Afrika bagian utara. Spinosaurus cukup terkenal saat ini, karena ukurannya mengalahkan Giganotosaurus dan Mapusaurus.', 'Karnivora', 'Cretaceous Akhir', 'Spinosauridae', 'Formasi Bahariya', 'https://upload.wikimedia.org/wikipedia/commons/5/56/Spinosaurus_TD.png', 5, 14, 7.4, 1),
('1765657784381', 'Carcharodontosaurus', 'Carcharodontosaurus merupakan salah satu dinosaurus karnivora terbesar yang pernah berjalan di Bumi. Karnivora raksasa ini merupakan salah satu yang paling besar pula dari kelompok Carnosauria. Dinosaurus ini hanya berukuran lebih besar dari kerabat Giganotosaurus. Nama genus Carcharodontosaurus berasal dari genus hiu Carcharodon', 'Karnivora', 'Cretaceous Akhir', 'Carcharodontosauridae', 'Formasi Bahariya', 'https://upload.wikimedia.org/wikipedia/commons/5/52/Carcharodontosaurus.png', 3.6, 13, 5.5, 1),
('1765657969720', 'Giganotosaurus', 'Giganotosaurus carolinii (berarti \"kadal raksasa dari selatan\") adalah pemangsa yang ganas, bersifat sama dengan Tyrannosaurus rex. Yang membedakan Giganotosaurus dengan yang lain hanyalah ukuran tubuhnya, 3 cakar berlengan besar (Tyrannosaurus rex hanya memiliki 2 cakar dan lengan sangat kecil), dan tulang-tulang seperti sirip pada seluruh permukaan atas tubuhnya, dari ujung moncongnya sampai ujung ekornya.', 'Karnivora', 'Cretaceous Akhir', 'Carcharodontosauridae', 'Formasi Candeleros/La Amarga/Huincul', 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Giganotos_Db.jpg', 3.7, 6, 7, 1),
('1765684946675', 'Paralititan', 'Paralititan (berarti \"kadal pasang surut\") adalah sebuah genus dinosaurus sauropoda titanosauria yang ditemukan di deposit pesisir periode Kapur Akhir dari Formasi Bahariya, Mesir. Genus ini hidup pada sekitar 99.6 dan 93.5 juta tahun lalu.', 'Herbivora', 'Cretaceous Akhir', 'Saltasauridae', 'Formasi Bahariya', 'https://upload.wikimedia.org/wikipedia/commons/8/84/Paralititan_stromeri.jpg', 12, 27, 30, 0),
('1765685341162', 'Therizinosaurus', 'Therizinosaurus adalah genus dari dinosaurus theropoda yang berukuran sangat besar. Fitur yang paling khas dari Therizinosaurus adalah kehadiran 3 buah cakar raksasa di masing-masing lengannya. Cakar besar merupakan hal umum yang terdapat dikelompok therizinosauridae, tetapi milik Therizinosaurus berukuran cukup besar mencapai panjang 90 sentimeter, Cakarnya relatif lurus, ramping, dan meruncing di ujungnya. Kebiasaan makan Therizinosaurus tidak diketahui karena tidak ada bahan tengkorak yang pernah ditemukan yang bisa menunjukkan makanan mereka. Namun, seperti Therizinosauria lainnya, mereka mungkin adalah pemakan tumbuhan/herbivor.', 'Herbivora', 'Cretaceous Akhir', 'Therizinosauridae', 'Formasi Nemegt', 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Therizinosaurus_Restoration.png', 5, 10, 5, 0),
('1765685995990', 'Torosaurus', 'Torosaurus adalah sebuah Genus dinosaurus ceratopsid yang hidup selama periode Kapur akhir (tahap Maastrichtian akhir), antara 68 dan 65 juta tahun lalu. Dinosaurus ini memiliki salah satu tengkorak terbesar dari setiap hewan darat yang dikenal. Tengkoraknya yang berbentuk jumbai mencapai 2,6 meter (8,5 kaki) panjangnya.', 'Herbivora', 'Cretaceous Akhir', 'Ceratopsidae', 'Formasi Hell\'s Creek', 'https://upload.wikimedia.org/wikipedia/commons/4/47/%22Torosaurus%22_utahensis_profile_reconstruction.jpg', 7, 7.9, 4, 0),
('1765686276649', 'Parasaurolophus', 'Parasaurolophus adalah dinosaurus dari famili Hadrosauridae yang hidup pada masa periode kapur akhir sekitar 76,5 - 73 juta tahun yang lalu. Ia memiliki jambul berbentuk tabung di belakang kepalanya, mungkin untuk berkomunikasi dengan sesamanya, dan mungkin untuk memamerkan pada betina ketika musim kawin. Parasaurolophus berarti \"kadal yang hampir berjambul\" fosilnya ditemukan di Amerika utara, New meksiko, dan Kanada.', 'Herbivora', 'Cretaceous Akhir', 'Hadrosauridae', 'Formasi Kaiparowits', 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Parasaurolophus_walkeri.png', 4.6, 9, 2, 1),
('1765695603370', 'Carnotaurus', 'Carnotaurus adalah sebuah genus dinosaurus Theropoda besar yang tinggal di Afrika Selatan selama akhir periode Cretaceous, sekitar 72 sampai dengan 69 juta tahun yang lalu. Di ambil dari bahasa Latin carno [carnis] (\"daging\") dan taurus (\"banteng\"), nama Carnotaurus berarti \"banteng pemakan daging\".', 'Karnivora', 'Cretaceous Akhir', 'Abelisauridae', 'Formasi La Colonia', 'https://upload.wikimedia.org/wikipedia/commons/8/81/Carnotaurus_Reconstruction_%282022%29.png', 3, 7.5, 2, 1),
('1765696381295', 'Koleken', 'Koleken adalah genus carnotaurinae abelisaurid dari Formasi La Colonia di Provinsi Chubut, Argentina. Nama Koleken adalah nama dalam bahasa Teushen yang diucapkan oleh penduduk asli Patagonia tengah yang berarti \"berasal dari tanah liat dan air\", mengingat spesimen tersebut ditemukan di bagian sedimen yang didominasi oleh batu lumpur yang melambangkan lingkungan muara.', 'Karnivora', 'Cretaceous Akhir', 'Abelisauridae', 'Formasi La Colonia', 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Koleken_TD.png', 2, 4.9, 1, 0),
('1765697690967', 'Edmontosaurus', 'Edmontosaurus adalah genus dinosaurus hadrosaurid. Fosil pertama yang dinamai Edmontosaurus ditemukan di Alberta selatan, di Formasi Lembah Horshoe. Spesies tipe E. regalis, dinamai oleh Lawrence Lambe pada tahun 1917, walaupun beberapa spesies lain yang kini diklasifikasikan sebagai Edmontosaurus telah dinamai terlebih dahulu. Salah satu yang paling dikenal adalah E. annectens, yang awalnya dinamai Claosaurus annectens oleh Othniel Charles Marsh pada tahun 1892 dan selama bertahun-tahun disebut Anatosaurus annectens.', 'Herbivora', 'Cretaceous Akhir', 'Hadrosauridae', 'Formasi Hell\'s Creek', 'https://cdn.zmescience.com/wp-content/uploads/2024/05/Edmontosaurus_sp._reconstruction_flipped.png', 3, 6.1, 5.6, 0),
('1765699113451', 'Ankylosaurus', 'Ankylosaurus adalah salah satu jenis dinosaurus yang hidup pada periode kapur akhir sekitar 68 juta hingga 65 juta tahun yang lalu di Amerika Utara. Ankylosaurus memiliki tubuh yang dilindungi oleh semacam cangkang keras yang membuat tubuhnya tidak bisa diserang dengan mudah, bahkan oleh Tyrannosaurus rex. Perisai tulang setebal 5 cm melindungi tubuhnya yang pendek, yang disangga oleh empat kakinya yang kuat, pendek dan gemuk. Di ekornya terdapat bola dari batu seberat 5 kg. Jika Ankylosaurus diadang oleh lawannya, ia akan menyerang lawan tersebut dengan ekor kerasnya dan dalam sekejap lawannya akan terjatuh.', 'Herbivora', 'Cretaceous Akhir', 'Ankylosauridae', 'Formasi Hell\'s Creek', 'https://upload.wikimedia.org/wikipedia/commons/c/c4/Ankylosaurus_magniventris_by_sphenaphinae.png', 3.4, 6, 4.5, 0),
('1765703604650', 'Chungkingosaurus', 'Chungkingosaurus jiangbeiensis adalah salah satu stegosauria terkecil dengan panjang kurang dari empat meter, meskipun tampaknya sudah dewasa, dilihat dari pengerasan tulang sakrumnya. Chungkingosaurus sangat mirip dengan Tuojiangosaurus, yang ditemukan di formasi yang sama, dalam banyak detail anatomi. Chungkingosaurus berbeda karena ukurannya yang lebih kecil, moncong dan rahang bawah depan yang lebih dalam (menghasilkan tengkorak yang relatif tinggi dan sempit), serta gigi yang tidak tumpang tindih dengan dentikel yang kurang menonjol.', 'Herbivora', 'Jurassic Akhir', 'Huayangosauridae', 'Formasi Shaximiao', 'https://upload.wikimedia.org/wikipedia/commons/7/73/Chungkingosaurus_jiangbeiensis.png', 3, 5, 1, 0),
('1765704380140', 'Mamenchisaurus', 'Mamenchisaurus adalah Sauropoda raksasa. Panjangnya berkisar antara 20–25 m dengan berat mencapai 23 ton, menjadikannya sebagai satu dari delapan belas dinosaurus terbesar. Leher Mamenchisaurus adalah leher paling panjang dari semua makhluk yang pernah berjalan di Bumi, yaitu antara 9–13 m. Walaupun sangat panjang, leher ini tidak terlalu luwes atau lentur karena ditopang oleh sistem tendon dan otot-otot yang sangat kuat. Beberapa ilustrasi pada zaman dahulu menganggap Mamenchisaurus bisa mengangkat lehernya lurus ke atas untuk mencapai daun di pohon yang tinggi, tetapi kini ide itu dibantah. Posisi kepala yang terlalu tinggi akan membuat jantung sulit memompa darah ke kepala dan leher sepanjang itu lebih mungkin digunakan untuk membantu kepalanya merenggut daun-daun yang berada jauh dari tubuhnya.', 'Herbivora', 'Jurassic Akhir', 'Mamenchisauridae', 'Formasi Shaximiao', 'https://thedinosaurs.org/wp-content/uploads/2023/10/F-Mamenchisaurus_UDL.jpg', 15, 35, 20, 1),
('1765704771092', 'Yangchuanosaurus', 'Yangchuanosaurus (\"Kadal Yongchuan\") adalah sebuah genus dari dinosaurus theropoda metriacanthosauridae yang hidup di Tiongkok pada periode Jura Tengah hingga Kapur Awal. Yangchuanosaurus ditemukan pada Formasi Shaximiao Atas dan Formasi Suining, dan merupakan predator terbesar pada lingkungan yang mencakup sauropoda seperti Mamenchisaurus dan Omeisaurus, beserta dengan hewan stegosaurus seperti Chialingosaurus, Tuojiangosaurus dan Chungkingosaurus.', 'Karnivora', 'Jurassic Akhir', 'Metriacanthosauridae', 'Formasi Shaximiao', 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Yangchuanosaurus_TD.png', 3, 8, 3, 0),
('1765705064390', 'Tuojiangosaurus', 'Tuojiangosaurus memiliki kepala yang sempit dan rendah, tubuh yang besar, dan gigi yang rendah seperti stegosaurid lainnya. Anggota tubuhnya, terutama lengan, agak pendek. Terdapat setidaknya dua puluh lima gigi rahang bawah. Gigi-gigi tersebut memiliki dasar yang tebal, cingulum, yang menyatu di bagian dalam membentuk tonjolan median vertikal berbentuk segitiga. Vertebra dorsal memiliki lengkungan saraf yang tinggi. Tulang belikat memiliki akromion berbentuk persegi panjang.', 'Herbivora', 'Jurassic Akhir', 'Huayangosauridae', 'Formasi Shaximiao', 'https://images.dinosaurpictures.org/tuojiangosaurus-multispinus-dinosaur-roman-garcia-mora_c6ba.jpg', 2.4, 6.5, 28, 0),
('1765705370896', 'Irritator Challengeri', 'Irritator adalah genus dinosaurus spinosaurid yang hidup di wilayah yang sekarang dikenal sebagai Brasil selama tahap Albian dari Periode Cretaceous Awal, sekitar 113 hingga 110 juta tahun yang lalu. Nama genus ini berasal dari kata \"irritation\" (iritasi), yang mencerminkan perasaan para paleontolog yang menemukan tengkorak tersebut telah rusak parah dan diubah oleh para kolektor. Nama spesiesnya merupakan penghormatan kepada karakter fiksi Profesor Challenger dari novel-novel Arthur Conan Doyle.', 'Karnivora', 'Cretaceous Awal', 'Spinosauridae', 'Formasi Romualdo', 'https://upload.wikimedia.org/wikipedia/commons/3/35/Irritator_challengeri_by_PaleoGeek.png', 2.6, 6, 1, 1),
('1765705886956', 'Amargasaurus', 'Amargasaurus adalah sebuah genus dinosaurus sauropoda dicraeosauridae yang berasal dari periode Kapur Awal (129.4–122.46 jtl) di lokasi yang sekarang merupakan Argentina. Satu-satunya kerangka dari genus ini yang diketahui ditemukan pada 1984 dan pada hakikatnya lengkap, mencakup sebuah kerangka fragmenter, membuat Amargasaurus menjadi sauropoda yang paling baik diketahui dari periode Kapur Awal.', 'Herbivora', 'Cretaceous Awal', 'Dicraeosauridae', 'Formasi Candeleros/La Amarga/Huincul', 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Amargasaurus_Reconstruction_Fred_Wierum.png', 2.7, 9, 2.9, 0),
('1765706788183', 'Suchomimus', 'Suchomimus adalah sebuah genus dinosaurus spinosauridae yang hidup sekitar 125 dan 112 juta tahun lalu pada wilayah yang sekarang merupakan Niger, Afrika Barat, pada subkala Aptian sampai Albian pada periode Kapur Awal. Genusnya dinamai dan dideskripsikan oleh paleontolog Paul Sereno dan koleganya pada 1998, bedasarkan sebuah kerangka partial dari Formasi Elrhaz. nama genusnya merujuk kepada tengkorak Suchomimus yang dangkal dan panjang, sementara nama spesifiknya, Suchomimus tenerensis merujuk kepada lokalita sisa-sisa terawalnya yang pernah ditemukan, yaitu di Gurun Ténéré.', 'Karnivora', 'Cretaceous Awal', 'Spinosauridae', 'Formasi Elrhaz', 'https://upload.wikimedia.org/wikipedia/commons/8/8f/Life_reconstruction_of_Suchomimus_tenerensis.png', 3.3, 9.5, 2.5, 1),
('1765707750040', 'Ouranosaurus', 'Ouranosaurus adalah sebuah genus dari dinosaurus hadrosauriformes basal herbivora yang hidup pada subkala Aptium di periode Kapur Awal, di wilayah yang sekarang merupakan Niger dan Kamerun. Hewan ini dinamai pada 1976 oleh paleontolog Perancis Philippe Taquet; spesies tipenya adalah Ouranosaurus nigeriensis. Nama generiknya adalah kombinasi dari ourane, sebuah kata dengan beberapa makna dan sauros, nama Yunani untuk kadal. Nama spefisiknya, nigeriensis memiliki arti \"berasal dari Niger\".', 'Herbivora', 'Cretaceous Awal', 'Hadrosauridae', 'Formasi Elrhaz', 'https://upload.wikimedia.org/wikipedia/commons/4/42/Ouranosaurus_nigeriensis_restoration.png', 2.8, 7, 2.2, 0),
('2', 'Triceratops', 'Triceratops yang secara harfiah memiliki arti \"wajah bertanduk tiga\" berasal dari kata Yunani trí- (τρί-) berarti \"tiga\", kéras (κέρας) berarti \'tanduk\', dan ṓps (ὤψ) berarti \"wajah\". Triceratops menunjukkan evolusi konvergen dengan bovinae dan badak, menjadikannya salah satu dinosaurus (secara umum) dan anggota ceratopsia yang paling umum dikenali.', 'Herbivora', 'Cretaceous Akhir', 'Ceratopsidae', 'Formasi Hell\'s Creek', 'https://inaturalist-open-data.s3.amazonaws.com/photos/386074207/large.jpg', 3, 8, 6, 1),
('3', 'Brachiosaurus', 'Brachiosaurus adalah genus dinosaurus sauropoda yang hidup di Amerika Utara selama Jura Akhir, sekitar 154–150 juta tahun yang lalu. Dinosaurus ini memiliki leher panjang yang tidak proporsional, tengkorak kecil, dan berukuran besar secara keseluruhan, yang merupakan ciri-ciri khas sauropoda. Ciri Brachiosaurus yang bukan merupakan ciri khas sebagian besar sauropoda adalah kaki depan yang lebih panjang daripada kaki belakang, yang membuat badan yang cenderung curam, dan ekor yang lebih pendek secara proporsional.', 'Herbivora', 'Jurassic Akhir', 'Brachiosauridae', 'Formasi Morrison', 'https://upload.wikimedia.org/wikipedia/commons/0/07/Brachiosaurus_altithorax_side_profile.png', 12, 18, 28.3, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `category` enum('family','period','formation') NOT NULL,
  `name` varchar(100) NOT NULL,
  `coord_x` float DEFAULT 0,
  `coord_y` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tags`
--

INSERT INTO `tags` (`id`, `category`, `name`, `coord_x`, `coord_y`) VALUES
(1, 'family', 'Tyrannosauridae', 0, 0),
(2, 'family', 'Ceratopsidae', 0, 0),
(3, 'family', 'Brachiosauridae', 0, 0),
(4, 'family', 'Dromaeosauridae', 0, 0),
(5, 'family', 'Allosauridae', 0, 0),
(6, 'family', 'Diplodocidae', 0, 0),
(7, 'family', 'Spinosauridae', 0, 0),
(8, 'family', 'Carcharodontosauridae', 0, 0),
(9, 'family', 'Saltasauridae', 0, 0),
(10, 'family', 'Therizinosauridae', 0, 0),
(11, 'family', 'Hadrosauridae', 0, 0),
(12, 'period', 'Triassic Awal', 0, 0),
(13, 'period', 'Triassic Akhir', 0, 0),
(14, 'period', 'Jurassic Awal', 0, 0),
(15, 'period', 'Jurassic Tengah', 0, 0),
(16, 'period', 'Jurassic Akhir', 0, 0),
(17, 'period', 'Cretaceous Awal', 0, 0),
(18, 'period', 'Cretaceous Akhir', 0, 0),
(20, 'formation', 'Formasi Hell\'s Creek', 10, 24),
(21, 'formation', 'Formasi Nemegt', 69, 25),
(22, 'formation', 'Formasi Morrison', 11, 30),
(23, 'formation', 'Formasi Bahariya', 50, 35),
(24, 'formation', 'Formasi Candeleros/La Amarga/Huincul', 22, 82),
(25, 'formation', 'Formasi Kaiparowits', 9, 30),
(26, 'formation', 'Formasi La Colonia', 22, 86),
(27, 'family', 'Abelisauridae', 0, 0),
(28, 'family', 'Ankylosauridae', 0, 0),
(29, 'family', 'Huayangosauridae', 0, 0),
(30, 'formation', 'Formasi Shaximiao', 72, 36),
(31, 'family', 'Mamenchisauridae', 0, 0),
(32, 'family', 'Metriacanthosauridae', 0, 0),
(33, 'formation', 'Formasi Romualdo', 28, 62),
(34, 'family', 'Dicraeosauridae', 0, 0),
(35, 'formation', 'Formasi Elrhaz', 43, 45);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dinos`
--
ALTER TABLE `dinos`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
