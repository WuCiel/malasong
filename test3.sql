-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2016-11-20 09:07:58
-- 服务器版本： 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test3`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product` (`p_id` VARCHAR(4), `p_name` VARCHAR(4), `qoh` INT, `qoh_threshold` INT, `original_price` DECIMAL, `discnt_rate` DECIMAL, `s_id` VARCHAR(2))  BEGIN

insert into products values(p_id, p_name, qoh, qoh_threshold, original_price, discnt_rate, s_id);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_purchase` (`pur_no` VARCHAR(4), `c_id` VARCHAR(4), `e_id` VARCHAR(3), `p_id` VARCHAR(4), `pur_qty` INT)  BEGIN
select original_price*(1-discnt_rate) from products p where p.pid=p_id into @price;
select qoh from products p where p.pid=p_id into @old_qoh;
insert into purchases 	values(pur_no,c_id,e_id,p_id,pur_qty,current_timestamp,@price*pur_qty);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `report_monthly_sale` (`p_id` VARCHAR(4))  BEGIN
SELECT pname,date_format(ptime,'%b') as Month,date_format(ptime,'%Y') as Year,sum(qty) as qty_monthly,sum(total_price) as sale_monthly,format(sum(total_price)/sum(qty),2) as avgsale_monthly FROM products p1,purchases p2 where p1.pid=p2.pid and p1.pid=p_id GROUP BY month(ptime);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_pur_cid` (`c_id` VARCHAR(4))  BEGIN
SELECT COUNT(*) FROM purchases WHERE cid=c_id into @x;  
IF @x<=0 THEN
SELECT 'The customer’s ID does not exist.' AS warning;
ELSE
SELECT * FROM purchases where cid=c_id;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_customers` ()  BEGIN
    	SELECT * FROM customers;
    	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_employees` ()  BEGIN
SELECT * FROM employees;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_logs` ()  BEGIN
    	SELECT * FROM logs;
    	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_pro` (`p_id` VARCHAR(3))  BEGIN
select * from products p where p.pid=p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_products` ()  BEGIN
    	SELECT * FROM products;
    	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_purchases` ()  BEGIN
    	SELECT * FROM purchases ORDER BY ptime;
    	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_sales` ()  BEGIN

select pur,pur.pid,pname,qty,ptime,total_price from purchases pur,products pro where pur.pid=pro.pid;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_suppliers` ()  BEGIN
    	SELECT * FROM suppliers;
    	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `buycar`
--

CREATE TABLE `buycar` (
  `cid` varchar(20) NOT NULL,
  `pid` int(11) NOT NULL,
  `pcount` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=gb2312;

--
-- 转存表中的数据 `buycar`
--

INSERT INTO `buycar` (`cid`, `pid`, `pcount`) VALUES
('测试1', 4, 1);

-- --------------------------------------------------------

--
-- 表的结构 `customers`
--

CREATE TABLE `customers` (
  `cid` varchar(20) NOT NULL,
  `cpwd` varchar(100) NOT NULL,
  `cname` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `visits_made` int(5) DEFAULT NULL,
  `last_visit_time` datetime DEFAULT NULL,
  `isManager` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `customers`
--

INSERT INTO `customers` (`cid`, `cpwd`, `cname`, `city`, `visits_made`, `last_visit_time`, `isManager`) VALUES
('asd', 'bfd59291e825b5f2bbf1eb76569f8fe7', 'asd', '123', 1, '2016-11-20 16:58:22', 0),
('huanfengf', '348f5827dd8eeda2633655f75cc48d91', 'huanfeng', 'shenzhen', 1, '2016-11-19 22:19:25', 0),
('测试', 'f002874b0a2b6ee8953db8439bc80279', '测试', '深圳', 1, '2016-11-20 13:10:06', 0),
('测试1', '357a846cd52d670e742fe232089c40a7', '测试1', '深圳', 1, '2016-11-20 13:13:03', 1),
('演示1', '0bd46ad5e3ffb2c10fdb8964035891e7', '演示1', '深圳', 1, '2016-11-20 17:02:12', 0),
('烟雾', '348f5827dd8eeda2633655f75cc48d91', 'huanfeng', '深圳', 1, '2016-11-20 11:49:04', 0),
('陈恒丰', '9c40708e821e866d46964f7af77d7c3b', '焕峰', '深圳', 1, '2016-11-20 11:51:51', 0);

--
-- 触发器 `customers`
--
DELIMITER $$
CREATE TRIGGER `tg_update_cus` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
IF old.visits_made<>new.visits_made THEN
INSERT INTO logs VALUES(NULL,(select user()),current_timestamp,'customers','update',new.cid);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `employees`
--

CREATE TABLE `employees` (
  `eid` varchar(3) NOT NULL,
  `ename` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `employees`
--

INSERT INTO `employees` (`eid`, `ename`, `city`) VALUES
('e00', 'Amy', 'Vestal'),
('e01', 'Bob', 'Binghamton'),
('e02', 'John', 'Binghamton'),
('e03', 'Lisa', 'Binghamton'),
('e04', 'Matt', 'Vestal');

-- --------------------------------------------------------

--
-- 表的结构 `logs`
--

CREATE TABLE `logs` (
  `logid` int(5) NOT NULL,
  `who` varchar(10) NOT NULL,
  `time` datetime NOT NULL,
  `table_name` varchar(20) NOT NULL,
  `operation` varchar(6) NOT NULL,
  `key_value` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `logs`
--

INSERT INTO `logs` (`logid`, `who`, `time`, `table_name`, `operation`, `key_value`) VALUES
(29, 'root@local', '2016-06-21 09:32:17', 'purchases', 'insert', 'FGG'),
(30, 'root@local', '2016-06-21 09:32:17', 'products', 'update', 'pr03'),
(31, 'root@local', '2016-06-21 09:32:17', 'products', 'update', 'pr03'),
(32, 'root@local', '2016-06-21 09:32:17', 'customers', 'update', 'c001'),
(33, 'root@local', '2016-11-19 11:08:58', 'products', 'insert', '1'),
(34, 'root@local', '2016-11-19 11:26:12', 'products', 'insert', '2'),
(35, 'root@local', '2016-11-19 16:39:11', 'products', 'update', '1'),
(36, 'root@local', '2016-11-19 18:00:38', 'products', 'update', '1'),
(37, 'root@local', '2016-11-19 18:02:11', 'products', 'update', '2'),
(38, 'root@', '2016-11-19 21:34:00', 'products', 'insert', '3'),
(39, 'root@', '2016-11-19 21:34:48', 'products', 'insert', '4'),
(40, 'root@', '2016-11-19 21:35:26', 'products', 'insert', '5'),
(41, 'root@', '2016-11-19 23:03:37', 'products', 'insert', '6'),
(42, 'root@', '2016-11-19 23:04:35', 'products', 'insert', '7'),
(43, 'root@', '2016-11-19 23:05:17', 'products', 'insert', '8'),
(44, 'root@', '2016-11-19 23:05:54', 'products', 'insert', '9');

-- --------------------------------------------------------

--
-- 表的结构 `myorder`
--

CREATE TABLE `myorder` (
  `oid` int(11) NOT NULL,
  `cid` varchar(20) NOT NULL,
  `price` float(10,2) DEFAULT NULL,
  `hasFinish` tinyint(1) DEFAULT '0',
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `finishtime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gb2312;

--
-- 转存表中的数据 `myorder`
--

INSERT INTO `myorder` (`oid`, `cid`, `price`, `hasFinish`, `createtime`, `finishtime`) VALUES
(1, 'c000', 8.00, 0, '2016-11-19 15:50:07', '2016-11-19 15:50:07'),
(2, 'c000', 16.00, 0, '2016-11-19 15:50:07', '2016-11-19 15:50:07');

-- --------------------------------------------------------

--
-- 表的结构 `orderitem`
--

CREATE TABLE `orderitem` (
  `oid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `ccount` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=gb2312;

--
-- 转存表中的数据 `orderitem`
--

INSERT INTO `orderitem` (`oid`, `pid`, `ccount`) VALUES
(1, 3, 2),
(1, 4, 2),
(2, 4, 4),
(2, 3, 6);

--
-- 触发器 `orderitem`
--
DELIMITER $$
CREATE TRIGGER `t_afterinsert_on_orderitem` AFTER INSERT ON `orderitem` FOR EACH ROW UPDATE products set qoh=qoh-new.ccount WHERE pid=new.pid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `products`
--

CREATE TABLE `products` (
  `pid` int(11) NOT NULL,
  `pname` varchar(15) NOT NULL,
  `qoh` int(5) NOT NULL,
  `qoh_threshold` int(5) DEFAULT NULL,
  `original_price` decimal(6,2) DEFAULT NULL,
  `discnt_rate` decimal(3,2) DEFAULT NULL,
  `sid` varchar(2) DEFAULT NULL,
  `imgUrl` varchar(100) NOT NULL,
  `deps` text NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `products`
--

INSERT INTO `products` (`pid`, `pname`, `qoh`, `qoh_threshold`, `original_price`, `discnt_rate`, `sid`, `imgUrl`, `deps`, `type`) VALUES
(3, '算法导论', 50, 5, '20.00', '0.80', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/daolun.jpg', '是一本很好用的书', ''),
(4, '相机', 20, 5, '299.00', '1.00', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/camera.jpg', '相机相机', ''),
(5, '电脑', 50, 5, '3999.00', '0.95', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/computer.jpg', '大电脑', ''),
(6, '华为荣耀v8', 60, 5, '1566.00', '0.99', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/honorv8.jpg', '华为荣耀v8手机', ''),
(7, '魅族mx6', 19, 5, '1655.00', '1.00', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/meizuMx6.jpg', '魅族mx6手机', '手机'),
(8, '油画', 19, 5, '2655.00', '1.00', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/youhua.jpg', '风水油画', '艺术品'),
(9, '手表', 39, 5, '655.00', '1.00', 's0', 'http://szu.xuhuanfeng.cn:8080/MessageBoard/img/watch.jpg', '女士手表', '手表');

--
-- 触发器 `products`
--
DELIMITER $$
CREATE TRIGGER `tg_insert_pro` AFTER INSERT ON `products` FOR EACH ROW BEGIN
insert into logs values(NULL,(select user()),current_timestamp,'products','insert',new.pid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tg_update_pro` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
IF old.qoh<>new.qoh THEN
INSERT INTO logs VALUES(NULL,(select user()),current_timestamp,'products','update',new.pid);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `suppliers`
--

CREATE TABLE `suppliers` (
  `sid` varchar(2) NOT NULL,
  `sname` varchar(15) NOT NULL,
  `city` varchar(15) DEFAULT NULL,
  `telephone_no` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `suppliers`
--

INSERT INTO `suppliers` (`sid`, `sname`, `city`, `telephone_no`) VALUES
('s0', 'Supplier 1', 'Binghamton', '6075555431'),
('s1', 'Supplier 2', 'NYC', '6075555432');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buycar`
--
ALTER TABLE `buycar`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`eid`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`logid`);

--
-- Indexes for table `myorder`
--
ALTER TABLE `myorder`
  ADD PRIMARY KEY (`oid`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD PRIMARY KEY (`oid`,`pid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `sid` (`sid`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `sname` (`sname`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `logs`
--
ALTER TABLE `logs`
  MODIFY `logid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
--
-- 使用表AUTO_INCREMENT `myorder`
--
ALTER TABLE `myorder`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `products`
--
ALTER TABLE `products`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- 限制导出的表
--

--
-- 限制表 `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `suppliers` (`sid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
