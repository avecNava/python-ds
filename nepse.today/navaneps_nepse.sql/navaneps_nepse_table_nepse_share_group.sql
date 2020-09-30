
-- --------------------------------------------------------

--
-- Table structure for table `nepse_share_group`
--

DROP TABLE IF EXISTS `nepse_share_group`;
CREATE TABLE `nepse_share_group` (
  `GroupID` int(11) NOT NULL,
  `GroupName` varchar(20) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `login_id` int(11) NOT NULL,
  `created_by` varchar(25) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Scope` varchar(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nepse_share_group`
--

INSERT INTO `nepse_share_group` (`GroupID`, `GroupName`, `login_id`, `created_by`, `create_date`, `Scope`) VALUES
(1, 'Long term', 1, 'Test', '2017-12-14 15:04:22', '0'),
(2, 'Short term', 1, 'Test', '2017-12-14 15:04:27', '0'),
(3, 'Hamro Share Group', 151, 'Samit Raj Shilpkar', '2017-12-22 08:12:19', ''),
(4, 'EBL Nepal', 183, 'Arun Gautam', '2018-07-22 06:32:39', ''),
(5, 'suman vs sunita', 188, 'suman pokhrel', '2018-08-17 14:44:01', ''),
(8, 'Bonus', 168, 'Tirtha poudel', '2019-05-15 04:44:24', ''),
(9, 'Right', 168, 'Tirtha poudel', '2019-05-15 04:44:34', ''),
(10, 'Bought New', 168, 'Tirtha poudel', '2019-05-15 04:44:52', '');
