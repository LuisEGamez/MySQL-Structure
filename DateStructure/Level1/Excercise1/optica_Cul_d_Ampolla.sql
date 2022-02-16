-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 16-02-2022 a las 20:43:36
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `optica_Cul d'Ampolla`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(10) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `recomendador_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `direccion`, `telefono`, `email`, `fecha`, `recomendador_id`) VALUES
(1, 'Juan', 'C/ Lavandería 41 P3-2 Barcelona 08001 España', '639639639', 'qejhfdk@hdgda.com', '2022-01-04', NULL),
(2, 'Maria', 'C/ Llull 55 P7-2 Barcelona 08005 España', '654654654', 'uejergrjs@fhajha.com', '2022-01-17', NULL),
(3, 'Pepe', 'C/ Badajoz 41 P2-1 Barcelona 08005 España', '632632632', 'qwer@rewwq.com', '2022-02-02', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(10) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `sueldo` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombre`, `sueldo`) VALUES
(1, 'Ana', 20000),
(2, 'Laura', 22000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gafas`
--

CREATE TABLE `gafas` (
  `id_gafa` int(10) NOT NULL,
  `marca_id` int(10) NOT NULL,
  `modelo` varchar(10) NOT NULL,
  `graduacion_d` varchar(30) NOT NULL,
  `graduacion_i` varchar(30) NOT NULL,
  `tipo_montura` varchar(30) NOT NULL,
  `color_montura` varchar(30) NOT NULL,
  `color_cris_d` varchar(30) NOT NULL,
  `color_cris_i` varchar(30) NOT NULL,
  `precio` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gafas`
--

INSERT INTO `gafas` (`id_gafa`, `marca_id`, `modelo`, `graduacion_d`, `graduacion_i`, `tipo_montura`, `color_montura`, `color_cris_d`, `color_cris_i`, `precio`) VALUES
(1, 1, 'SD85A', '2', '2,3', 'Flotante', 'Rojo', 'Transparente', 'Transparente', 100),
(2, 2, 'FRT52', '3', '3', 'Pasta', 'Negra', 'Transparente', 'Transparente', 120),
(3, 3, 'ADR785', '1', '2', 'Metalica', 'Verde', 'Negro', 'Negro', 160),
(4, 4, '485R41', '2', '1', 'Metalica', 'Rosa', 'Transparente', 'Transparente', 140),
(5, 5, '8569EER', '5', '5', 'Pasta', 'Negra', 'Negro', 'Negro', 180),
(6, 6, 'R7854', '0,5', '1', 'Flotante', 'Blanco', 'Transparente', 'Transparente', 110);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas_gafas`
--

CREATE TABLE `marcas_gafas` (
  `id_marca` int(10) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `proveedor_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marcas_gafas`
--

INSERT INTO `marcas_gafas` (`id_marca`, `nombre`, `proveedor_id`) VALUES
(1, 'Ray Ban', 1),
(2, 'Tous', 1),
(3, 'Arnete', 2),
(4, 'Carrera', 2),
(5, 'Armani', 3),
(6, 'Oakley', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(10) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `fax` varchar(30) NOT NULL,
  `direccion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `telefono`, `fax`, `direccion`) VALUES
(1, 'Vision CAP', '6587412598', '698532698', 'C/ Valencia 123 bajo Barcelona 08008 España'),
(2, 'VisionX', '654321987', '654321988', 'C/ Badajoz 45 P3-2 Barcelona 08001 España'),
(3, 'Max Vision', '639852147', '666999333', 'C/ Av Constitucion 52 bajo Granada 18318 España');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(10) NOT NULL,
  `empleado_id` int(10) NOT NULL,
  `cliente_id` int(10) NOT NULL,
  `gafa_id` int(10) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `empleado_id`, `cliente_id`, `gafa_id`, `fecha`) VALUES
(1, 1, 1, 1, '2022-02-01'),
(2, 1, 1, 2, '2022-02-03'),
(3, 1, 3, 3, '2022-02-07'),
(5, 2, 1, 4, '2022-02-10'),
(6, 2, 2, 5, '2022-02-14');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `recomendador_id_2` (`recomendador_id`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `gafas`
--
ALTER TABLE `gafas`
  ADD PRIMARY KEY (`id_gafa`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `marcas_gafas`
--
ALTER TABLE `marcas_gafas`
  ADD PRIMARY KEY (`id_marca`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD UNIQUE KEY `gafa_id` (`gafa_id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `empleado_id` (`empleado_id`),
  ADD KEY `gafa_id_2` (`gafa_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `gafas`
--
ALTER TABLE `gafas`
  MODIFY `id_gafa` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `marcas_gafas`
--
ALTER TABLE `marcas_gafas`
  MODIFY `id_marca` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`recomendador_id`) REFERENCES `clientes` (`id_cliente`);

--
-- Filtros para la tabla `gafas`
--
ALTER TABLE `gafas`
  ADD CONSTRAINT `gafas_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas_gafas` (`id_marca`);

--
-- Filtros para la tabla `marcas_gafas`
--
ALTER TABLE `marcas_gafas`
  ADD CONSTRAINT `marcas_gafas_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id_empleado`),
  ADD CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `ventas_ibfk_4` FOREIGN KEY (`gafa_id`) REFERENCES `gafas` (`id_gafa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
