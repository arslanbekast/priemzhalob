<?php
require_once ("includes/config.php");

// Проверка сессии
if (isset($_SESSION['login']) && isset($_SESSION['pass'])) {
	$session_login = $_SESSION['login'];
	$session_pass = $_SESSION['pass'];
	$result = mysql_query("SELECT * FROM users WHERE login='$session_login' AND pass='$session_pass'");
	$row = mysql_fetch_assoc($result);
	if ($row) {
		$loged = TRUE;
		$result_admin = mysql_query("SELECT * FROM admin WHERE user_id='$row[id]'");
		$row_admin = mysql_fetch_assoc($result_admin);
		if ($row_admin) {$admin = TRUE;}
		
	}
	else {
		unset($_SESSION['login']);
		unset($_SESSION['pass']);
		session_destroy();
	}

}
else {
	$loged = FALSE;
	session_destroy();
}
// КОНЕЦ Проверка сессии
?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8" />
	<link rel="stylesheet" href="css/style.css" />
	<title>Правила</title>
	<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
</head>
<body>
	<!--Основная часть-->
	<div id="container">
		<!--Шапка-->
		<header>
			<h1><a href="./" title="Перейти на главную страницу"></a></h1>
				<div id="greeting">
					<?php
						if ($loged) {
							echo "Здравствуйте, <b>" . $_SESSION['login'] . "</b>! | ";
							echo " <a href='./?logout' class='vhod_text'>Выйти</a>";
						}	
						else {
							echo "<a href='./' class='vhod_text'>Вход</a>";
						}
					?>	
					<a href="./rules.php">Правила</a>	
				</div>
		</header>
		<!--/Шапка-->
		<div id='rules'>
			<h2 style="color:#505050;">Правила нашего сайта</h2>
		</div>
		<!-- Подвал -->
		<footer>
			<p>Проект создан при поддержке студии АКМ Медиа в Чеченской республике в рамках программы "Народный проект". Грозный <?=Date('Y');?> год.</p>
			<!-- <p>Посмотреть другие проекты студии.</p> -->
		</footer>
		<!-- /Подвал -->
	</div>
	<!--/Основная часть-->
</body>
</html>