<?php
header("Content-Type: text/html; charset=utf-8");
header('Cache-Control: no-cache, no-store, must-revalidate'); // HTTP 1.1.
header('Cache-Control: post-check=0, pre-check=0', FALSE);
header('Cache-Control: max-age=0');
header('Expires: Thu, 01 Jan 1970 00:00:01 GMT'); // Proxies.
header('Pragma: no-cache'); // HTTP 1.0.
// Заглушка для IE
if (preg_match("/MSIE/", $_SERVER['HTTP_USER_AGENT'])) {
		echo "<div style='margin: 50px auto;width:800px;text-align:center;padding: 50px 0; color: #505050; font:22pt \"Segoe UI\";'>Извините, наш проект не поддерживает браузер Internet Explorer. Пожалуйста, воспользуйтесь другим браузером.</div>";
		exit();
}
// КОНЕЦ Заглушка для IE
$db_hostname = "localhost";
$db_username = "root";
$db_password = "";
$db_database = "pomogite_db";
$db_server=mysql_connect($db_hostname, $db_username, $db_password);
if (!$db_server) die("Невозможно подключиться к MySQL: " . mysql_error());
mysql_select_db($db_database, $db_server)
	or die("Невозможно выбрать базу данных: " . mysql_error());
mysql_query('SET NAMES utf8');

session_start();

// Инициализация переменных
$loged = FALSE;
$admin = FALSE;
$login = $pass = $captcha = $res_captcha = $password = "";

function clear($var) {
		$var = trim($var);
        $var = strip_tags($var);
        $var = htmlentities($var, ENT_IGNORE, "UTF-8");
        $var = stripcslashes($var);
        return mysql_real_escape_string($var);
 }
 function captcha() {
 	global $c;
 	$a = mt_rand(1,9);
	$b = mt_rand(1,9);
	$c = $a + $b;
	switch ($b) {
	case 1:
		$b = "один";
		break;
	case 2:
		$b = "два";
		break;
	case 3:
		$b = "три";
		break;
	case 4:
		$b = "четыре";
		break;
	case 5:
		$b = "пять";
		break;
	case 6:
		$b = "шесть";
		break;
	case 7:
		$b = "семь";
		break;
	case 8:
		$b = "восемь";
		break;
	case 9:
		$b = "девять";
		break;
					}
	$res = "<span class='a'>" . $a . "</span>" . "<span class='plus'> + </span>" . "<span class='b'>" . $b . "</span>";
	return $res;
 }
?>