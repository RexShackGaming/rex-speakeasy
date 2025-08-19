CREATE TABLE `rex_speakeasy` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `speakeasyid` varchar(50) DEFAULT NULL,
    `corn` int(3) NOT NULL DEFAULT 0,
    `sugar` int(3) NOT NULL DEFAULT 0,
    `water` int(3) NOT NULL DEFAULT 0,
    `yeast` int(3) NOT NULL DEFAULT 0,
    `jug` int(3) NOT NULL DEFAULT 0,
    `mash` int(3) NOT NULL DEFAULT 0,
    `moonshine` int(3) NOT NULL DEFAULT 0,
    `stock` int(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `rex_speakeasy` (`speakeasyid`, `corn`, `sugar`, `water`, `yeast`, `jug`, `mash`, `moonshine`, `stock`) VALUES 
('lemoynese', '0', '0', '0', '0', '0', '0', '0', '0'),
('cattailse', '0', '0', '0', '0', '0', '0', '0', '0'),
('newaustinse', '0', '0', '0', '0', '0', '0', '0', '0'),
('hanoverse', '0', '0', '0', '0', '0', '0', '0', '0'),
('manzanitase', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `management_funds` (`job_name`, `amount`, `type`) VALUES
('lemoynese', 0, 'boss'),
('cattailse', 0, 'boss'),
('newaustinse', 0, 'boss'),
('hanoverse', 0, 'boss'),
('manzanitase', 0, 'boss');