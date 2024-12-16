-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 10-09-2024 a las 18:56:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `planify`
--
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tipo` enum('administrador','cliente') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `clave`, `telefono`, `email`, `tipo`) VALUES
(1, 'admin', '$2y$10$pb/1cV9ZhcT6eATfUqyor.gQoeQrlTZ0CDiozQ19cmbWDSRejtTM2', NULL, NULL, 'administrador'),
(2, 'Juan', '$2y$10$VPesJtD90an8f27EVrFNougoKdnFpe/oq804wit2agAwkA9GbsYXi', NULL, NULL, 'cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Cultura'),
(2, 'Aventura'),
(3, 'Gastronomía'),
(4, 'Relajación'),
(5, 'Naturaleza');

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `categoria` int(11) DEFAULT NULL,
  `duracion` decimal(5,2) NOT NULL,
  `ubicacion` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_categoria` (`categoria`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`categoria`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id`, `titulo`, `descripcion`, `precio`, `categoria`, `duracion`, `ubicacion`, `fecha`, `hora`) VALUES
(1, 'Recorrido por la Ciudad', 'Explora los principales puntos turísticos de la ciudad con un guía local.', 50.00, 1, 3.00, 'Centro de la Ciudad', '2024-09-15', '10:00:00'),
(2, 'Visita a Bodegas con Cata de Vinos', 'Disfruta de una visita guiada a bodegas locales con cata de vinos incluidos.', 80.00, 1, 4.00, 'Bodegas del Valle', '2024-09-20', '15:00:00'),
(3, 'Clase de Cocina Local', 'Aprende a preparar platos típicos con un chef local.', 60.00, 3, 2.00, 'Escuela de Cocina Gourmet', '2024-09-22', '18:00:00'),
(4, 'Excursión en Barco al Atardecer', 'Disfruta de una tranquila excursión en barco durante el atardecer.', 75.00, 2, 2.00, 'Puerto Deportivo', '2024-09-25', '19:00:00'),
(5, 'Escalada en Roca', 'Desafía tus habilidades con una sesión de escalada en roca guiada.', 100.00, 2, 5.00, 'Zona de Escalada de Montaña', '2024-09-30', '09:00:00'),
(6, 'Masaje Relax', 'Relájate con un masaje completo en un spa local.', 45.00, 4, 1.00, 'Spa Wellness', '2024-09-18', '14:00:00'),
(7, 'Yoga en la Playa', 'Participa en una sesión de yoga al amanecer en la playa.', 30.00, 4, 1.50, 'Playa de la Arena', '2024-09-19', '07:00:00'),
(8, 'Senderismo en el Parque Nacional', 'Explora senderos naturales en un parque nacional con un guía experto.', 90.00, 5, 6.00, 'Parque Nacional de la Sierra', '2024-09-28', '08:00:00'),
(9, 'Observación de Aves', 'Participa en una excursión para observar aves en su hábitat natural.', 50.00, 5, 4.00, 'Reserva Natural de los Aves', '2024-10-01', '06:00:00');


--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `actividad_id` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `puntuacion` int(11) DEFAULT NULL CHECK (`puntuacion` >= 1 and `puntuacion` <= 5),
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `actividad_id` (`actividad_id`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`actividad_id`) REFERENCES `actividades` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `actividad_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_id` (`usuario_id`, `actividad_id`),
  KEY `actividad_id` (`actividad_id`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`actividad_id`) REFERENCES `actividades` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `itinerarios`
--

CREATE TABLE `itinerarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `presupuesto` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `itinerarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `itinerarios`
--

INSERT INTO `itinerarios` (`id`, `usuario_id`, `nombre`, `descripcion`, `fecha_creacion`, `presupuesto`) VALUES
(1, 2, 'Verano 2025', 'FWfrfW', '2024-09-09 20:47:32', 200.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `itinerario_actividades`
--

CREATE TABLE `itinerario_actividades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itinerario_id` int(11) NOT NULL,
  `actividad_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `itinerario_id` (`itinerario_id`, `actividad_id`),
  KEY `actividad_id` (`actividad_id`),
  CONSTRAINT `itinerario_actividades_ibfk_1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `itinerario_actividades_ibfk_2` FOREIGN KEY (`actividad_id`) REFERENCES `actividades` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `itinerario_actividades`
--

INSERT INTO `itinerario_actividades` (`id`, `itinerario_id`, `actividad_id`) VALUES
(1, 1, 1),
(2, 1, 4),
(3, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `leida` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itinerario_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_reserva` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` enum('pendiente','confirmada','cancelada','pagada') DEFAULT 'pendiente',
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `itinerario_id` (`itinerario_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerarios` (`id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `itinerario_id`, `usuario_id`, `fecha_reserva`, `estado`, `monto`) VALUES

(1, 1, 2, '2024-09-09 20:39:04', 'pagada', 50.00),
(2, 1, 2, '2024-09-09 20:49:35', 'cancelada', 50.00);


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
