<?php
require_once ("includes/config.php");

// Обработка выхода
if (isset($_GET['logout'])) {
	$logout = $_GET['logout'];
	$logout = TRUE;
	if ($logout) {
		$loged = FALSE;
		session_unset();
		session_destroy();
		setcookie(session_name(), session_id(), time()-60*60*24);
		header('Location: /');
	}
}
// КОНЕЦ Обработка выхода

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
		else {$admin = FALSE;}
		
	}
	else {
		session_unset();
		session_destroy();
		setcookie(session_name(), session_id(), time()-60*60*24);
	}

}
else {
	$loged = FALSE;
	session_destroy();
	setcookie(session_name(), session_id(), time()-60*60*24);
}
// КОНЕЦ Проверка сессии
?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8" />
	<link rel="stylesheet" href="css/style.css" />
	<?php if ($admin) { ?><link rel="stylesheet" href="css/admin.css" /><?php } ?>
	<script src="js/jquery-2.1.4.min.js"></script>
	<script src="js/processor.js"></script>
	<title>95.PriemZhalob.ru - проект для приема жалоб, просьб и предложений для жителей ЧР от АКМ МЕДИА.</title>
	<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
	<?php if (!$loged) { ?>
	<script type="text/javascript">
		var cookie = document.cookie;
		if(cookie != "") {
			var date = new Date;
			date.setDate(date.getDate() - 1000);
			date = date.toUTCString();
			var cookieArray = cookie.split(";"); 
			for (var i = 0; i < cookieArray.length; i++) {
		 		cookie = cookieArray[i].split("=");
  				document.cookie = cookie[0] + "=;" + "expires=" + date;
			}
		}
	</script>
	<?php } ?>
</head>
<body>
	<div id="is_answer_block"><div id="answer_close"><a href='#' onclick="return false;">Закрыть</a></div></div>
	<!--Основная часть-->
	<div id="container">
		<div id="system_info_block">
			<div id="system_info">
				<span id="system_info_text"></span>
				<button id="system_info_ok">Ок</button>
			</div>
		</div>
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
		<?php 
			if ($loged) {
				if ($admin) {include "includes/admin.php";}
				else {
		?>
		<!--Форма для написания жалобы-->
			
			<div id="main">
				<div id="is_answer">
					
					<h3>Уважаемый <?=$session_login?>, для Ваших сообщений есть ответы:</h3>
				</div>

					<p class='complaint_errors' id="error_complaint_theme"></p>
					<input type="text" name="complaint_theme" id="complaint_theme" placeholder="Тема жалобы или просьбы" class="theme"><br />
					<p class='complaint_errors' id="error_complaint_text"></p>
					<textarea name="complaint_text" id="complaint_text" placeholder="* ВАЖНО! Прежде чем Вы напишите жалобу или просьбу - обязательно ознакомтесь с правилами нашего проекта!"></textarea><br />
					
					<div id="main_forms">
						<p class='complaint_errors' id="error_captcha" style="position:absolute;left:263px;"></p>
						<div class="captcha"><?php echo captcha(); ?></div>
						<input type="text" name="captcha" id="captcha" maxlength="2" placeholder="Введите ответ" />
						<input type="hidden" name="res_captcha" id="res_captcha" maxlength="2" value="<?=$c;?>">
						<input type="reset" name="reset" id="reset" value="Очистить" />
						<button id="complaint_submit">Отправить</button>
					</div>
			</div>
			<script type="text/javascript">
				$(document).ready(function(){
					setTimeout(isAnswer,1000);
				});
			</script>
		<!--/Форма для написания жалобы-->
		<?php } }
			else {
		?>
		<div id="vhod_reg_block">
		<!--Вход на сайт-->
			<div id="vhod" class="active">
				<p>Вход</p>
			</div>
			<div id="reg">
				<p>Регистрация</p>
			</div>
			<div id="vhod_reg">
				<div id="vhod_reg_forms">
					<p class='vhod_reg_errors' id='error_logining'></p>
					<p class='vhod_reg_errors' id='error_login'></p>
					<input type="text" name="login" id="login" placeholder="Логин" />
					<p class='vhod_reg_errors' id='error_pass'></p>
					<input type="password" name="pass" id="pass" placeholder="Пароль" />
					<div class="captcha"><?php echo captcha(); ?></div>
					<p class='vhod_reg_errors' id='error_captcha'></p>
					<input type="text" name="captcha" id="captcha" maxlength="2" placeholder="Введите ответ" /><br />
					<input type="hidden" name="res_captcha" id="res_captcha" maxlength="2" value="<?=$c?>" />
					<button id="button">Войти</button>
					<button id="reg_button">Зарегистрировать</button>
				</div>
			</div>
		</div>
		<?php } ?>
		<!-- Подвал -->
		<footer>
			<p>Проект создан при поддержке студии АКМ Медиа в Чеченской республике в рамках программы "Народный проект". Грозный <?=Date('Y');?> год.</p>
		</footer>
		<!-- /Подвал -->
	</div>
	<!--/Основная часть-->
</body>
</html>
