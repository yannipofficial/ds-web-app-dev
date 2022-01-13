-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2022 at 05:05 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uop`
--

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `content`, `added_at`) VALUES
(71, 4, 'Προδιαγραφές για ατομική εργασία', 'Η εφαρμογή θα έχει δύο βασικά μέρη. Το πρώτο μέρος θα αφορά τους καθηγητές του τμήματος, οι οποίοι, αφου κάνουν login στην εφαρμογή θα μπορούν να αναρτούν  ανακοινώσεις. Δεν είναι απαραίτητο να δημιουργηθεί registration form. Τα usernames και τα passwords μέσω των οποίων θα μπορούν να κάνουν login οι καθηγητές, θα προϋπάρχουν στον πίνακα users της Βάσης Δεδομένων. Για κάθε ανακοίνωση που αποθηκεύεται στη βάση δεδομένων, θα αποθηκεύεται και η πληροφορία για το ποιος καθηγητής δημιούργησε την ανακοίνωση.\nΣτο δεύτερο μέρος της εφαρμογής, οι φοιτητές και οι φοιτητριες (δεν απαιτείται login) θα μπορούν να βλέπουν τις ανακοινώσεις που έχουν ανεβάσει οι καθηγητές. Αρχικά, όλες οι ανακοινώσεις θα εμφανίζονται στην οθόνη. Η παρουσίαση της κάθε ανακοίνωσης θα πρέπει να συνοδεύεται από τον συντάκτη της (δηλαδή το επίθετο του καθηγητή που την δημιούργησε). Οι φοιτητές και οι φοιτήτριες, θα έχουν στη διάθεση τους ένα φιλτρο μέσω του οποίου θα μπορούν να δουν τις ανακοινώσεις ενός συγκεκριμένου καθηγητή. Συνεπώς, η εφαρμογή θα προσφέρει ένα dropdown list (<select>) όπου θα φορτώνονται δυναμικά από τη Βάση Δεδομένων τα επίθετα των καθηγητών. Όταν ο χρήστης επιλέγει το επίθετο κάποιου καθηγητή, τότε θα εμφανίζονται μόνο οι ανακοινώσεις του συγκεκριμένου καθηγητή.\n', '2022-01-12 22:47:41'),
(72, 4, 'Προθεσμία', 'Προθεσμία για την ολοκλήρωση της εργασίας ορίζεται η Κυριακή 16 Ιανουαρίου 2022. Μετά την συγκεκριμένη ημερομηνία δεν επιτρέπονται αλλαγές στο github repository.', '2022-01-12 22:48:05'),
(73, 1, 'Github Repository', 'Θα πρέπει να δημιουργήσετε ένα github repository όπου όλα τα μέλη της ομάδας και ο διδάσκων (stougsch, email: stefanos.ougiaroglou@gmail.com) θα είναι collaborators. Ο κώδικας της εφαρμογής θα πρέπει να είναι διαθέσιμος στο εν λόγω repository. O διδάσκων, θα πρέπει να είναι collaborator από την αρχή (από τις 26 Νοεμβρίου) ώστε να μπορεί να παρακολουθεί την εξέλιξη του project κατα τη διάρκεια του εξαμήνου. ', '2022-01-12 22:50:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `password`) VALUES
(1, 'admin', 'PANTAZOPOULOS', 'password'),
(4, 'stoug', 'OUGIAROGLOU', 'password');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
