-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierGoToPub`
--

DROP TABLE IF EXISTS `PartierGoToPub`;
CREATE TABLE IF NOT EXISTS `PartierGoToPub` (
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  PRIMARY KEY (`idPartier`,`idPub`),
  KEY `fk_Partier_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------