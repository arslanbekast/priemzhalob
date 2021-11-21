<?php 
include ("includes/config.php");

// Обработка входа и регистрации
if (isset($_POST['submit']) || isset($_POST['reg'])) {
	$login = clear($_POST['login']);
	$pass = clear($_POST['pass']);
	$captcha = (int) $_POST['captcha'];
	$res_captcha = (int) $_POST['res_captcha'];
	$error_login = FALSE;
	$error_pass = FALSE;
	$error_captcha = FALSE;
	if ($login == "") {
		// $error_login = "Вы не ввели логин.";
		$error_login = TRUE;
	}
	else if (strlen($login) < 4 or strlen($login) > 30) {
		// $error_login = "Логин должен быть не меньше 4-х символов и не больше 30.";
		$error_login = TRUE;
		}
	else if (preg_match("/[^A-Za-z0-9-_]/", $login)) {
		// $error_login = "Логин может содержать только буквы латинского алфавита, цифры, дефис и знак подчеркивания.";
		$error_login = TRUE;
	}
	else if (!preg_match("/[A-Za-z]/", substr($login, 0, 1))) {
		// $error_login = "Логин должен начинаться с буквы.";
		$error_login = TRUE;
	}
	if ($pass == "") {
		// $error_pass = "Вы не ввели пароль.";
		$error_pass = TRUE;
	}
	else if (strlen($pass) < 4 or strlen($pass) > 30) {
		// $error_pass = "Пароль должен быть не меньше 4-х символов и не больше 30.";
		$error_pass = TRUE;
		}
	else if (preg_match("/[А-Яа-я]/", $pass)) {
		// $error_pass = "Пароль не должен содержать русские символы.";
		$error_pass = TRUE;
		}
	if ($captcha == "") {
		// $error_captcha = "Вы не ввели ответ.";
		$error_captcha = TRUE;
	}
	else if ($captcha != $res_captcha) {
		// $error_captcha = "Ответ не верный.";
		$error_captcha = TRUE;
	}

	if (!$error_login && !$error_pass && !$error_captcha)  {
		if (isset($_POST['submit']) && !isset($_POST['reg'])) {
			$password = md5(md5(md5($pass)));
			$result = mysql_query("SELECT * FROM users WHERE login='$login' AND pass='$password'");
			$row = mysql_fetch_assoc($result);
			if ($row) {
				$loged = TRUE;
				$login = $row['login'];
				$pass = $row['pass'];
				$_SESSION['login'] = $login;
				$_SESSION['pass'] = $pass;
				echo $loged;
			}
			else {
				echo "Неверный логин или пароль.";
			}
		}
		else if (isset($_POST['reg']) && !isset($_POST['submit'])) {
			$result = mysql_query("SELECT COUNT(id) FROM users WHERE login='$login'");
			if (mysql_result($result, 0)) {
				 echo "Такой логин уже существует. Пожалуйста, придумайте другой.";
			}
			else {
				$password = md5(md5(md5($pass)));
				if (mysql_query("INSERT INTO users (login,pass) VALUES ('$login', '$password')")) {
					// $signup = "Спасибо за регистрацию. Пожалуйста, войдите на сайт, используя свои введенные во время регистрации данные.";
					$_SESSION['login'] = $login;
					$_SESSION['pass'] = $password;
					$loged = TRUE;
					echo $loged;
				}
				else {
					echo "Извините, во время регистрации произошел технический сбой. Пожалуйста, попробуйте еще раз.";
				}
			}
		}
	}
}
// КОНЕЦ Обработка входа

// Обработка жалобы
if (isset($_POST['complaint_submit'])) {
	$complaint_theme = clear($_POST['complaint_theme']);
	$complaint_text = clear($_POST['complaint_text']);
	$captcha = (int) $_POST['captcha'];
	$res_captcha = (int) $_POST['res_captcha'];
	$error_complaint_theme = FALSE;
	$error_complaint_text = FALSE;
	$error_captcha = FALSE;
	if($complaint_theme == "") {
		// $error_complaint_theme = "Вы не ввели тему жалобы.";
		$error_complaint_theme = TRUE;
	}
	else if (strlen($complaint_theme) < 3) {
		// $error_complaint_theme = "Тема должна содержать не меньше 3-х символов.";
		$error_complaint_theme = TRUE;
	}

	if ($complaint_text == "") {
		// $error_complaint_text = "Вы не ввели текст жалобы.";
		$error_complaint_text = TRUE;
	}
	else if (strlen($complaint_text) < 5) {
		// $error_complaint_text = "Текст жалобы должен содержать не меньше 5 символов.";
		$error_complaint_text = TRUE;
	}

	if ($captcha == "") {
		// $error_captcha = "Вы не ввели ответ";
		$error_captcha = TRUE;
	}
	else if ($captcha != $res_captcha) {
		// $error_captcha = "Ответ не верный.";
		$error_captcha = TRUE;
	}

	if (!$error_complaint_theme && !$error_complaint_text && !$error_captcha) {
		$result = mysql_query("SELECT id FROM users WHERE login='$_SESSION[login]' AND pass='$_SESSION[pass]'");
		$row = mysql_fetch_assoc($result);
		$user_id = (int) $row['id'];
		if (mysql_query("INSERT INTO complaints (user_id,theme,complaint) VALUES ('$user_id', '$complaint_theme', '$complaint_text')")) {
			echo "Спасибо. Ваша жалоба отправлена на обработку.";
		}
		else {
			echo "Извините, произошел технический сбой. Пожалуйста, попробуйте еще раз.";
		}
	}

}
// КОНЕЦ Обработка жалобы

// Обновление капчи
if (isset($_POST['reload_captcha'])) {
	$mass = array();
	$mass['captcha'] = captcha();
	$mass['res_captcha'] = $c;
	$mass = json_encode($mass);
	echo $mass;
}

// Проверка существования ответа для жалобы пользователя
if (isset($_POST['is_answer'])) {
	$login = $_SESSION['login'];
	$result = mysql_query("SELECT id FROM users WHERE login='$login'");
	$row = mysql_fetch_assoc($result);
	$user_id = $row['id'];
	$result = mysql_query("SELECT id,theme,complaint FROM complaints WHERE user_id='$user_id'");
	if (mysql_num_rows($result) > 0) {
		$row = mysql_fetch_assoc($result);
		$answer_count = 0;
		$complaint_answer = array();
		do {
			$complaint_id = $row['id'];
			$result_answer = mysql_query("SELECT COUNT(id) FROM answers WHERE complaint_id='$complaint_id' AND user_read = 0");
			if (mysql_result($result_answer,0) > 0) {
				$complaint_answer[] = $row; 
				$answer_count++;
			}
		} while($row = mysql_fetch_assoc($result));
		if ($answer_count > 0) {
			$complaint_answer = json_encode($complaint_answer);
			echo $complaint_answer;
		}
		else {echo 0;}
	}
	else {echo 0;}
}

// Получение ответа для жалобы
if (isset($_POST['get_answer'])) {
	$complaint_id = (int) $_POST['complaint_id'];
	$result = mysql_query("SELECT answer FROM answers WHERE complaint_id='$complaint_id'");
	if (mysql_num_rows($result) > 0) {
		mysql_query("UPDATE answers SET user_read=1 WHERE complaint_id='$complaint_id'");
		$row = mysql_fetch_assoc($result);
		$answer = $row['answer'];
		echo $answer;
	}
	else {echo "Извините, не удалось загрузить ответ.";}
	
}
?>