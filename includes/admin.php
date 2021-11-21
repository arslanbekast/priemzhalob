<?php 
if ($loged) {
	if ($admin) {
?>
<!-- Админская часть -->
<div id='admin_block'>
<div>
	<a href="./?is_answered">Жалобы с ответами</a> | 
	<a href="./">Жалобы без ответов</a>
	<br /><br />
</div>
<?php
// Вывод текста жалобы
if (isset($_GET['complaint_id'])) {
	$complaint_id = (int) $_GET['complaint_id'];
	$result = mysql_query("SELECT * FROM complaints WHERE id='$complaint_id'");
	$row = mysql_fetch_assoc($result);
	$user_id = $row['user_id'];
	$complaint_theme = $row['theme'];
	$complaint_text = $row['complaint'];
	$complaint_date = $row['date'];
	$result_user = mysql_query("SELECT login FROM users WHERE id='$user_id'");
	$row_user = mysql_fetch_assoc($result_user);
	$user = $row_user['login'];
	echo "<div style='font-size:10pt; width:100%;'><span>Опубликовал: <b><a href='/?user_id=$user_id' title='Открыть все жалобы этого пользователя' style='text-decoration:none;color:#505050;'>$user</a></b></span>
				<span style='float:right;'>Дата: $complaint_date</span>
		</div>";
	echo "<h2>$complaint_theme</h2>
			<p style='text-align:justify;line-height:1.5em;'>$complaint_text</p>";
	// Обработка формы ответа
	if (isset($_POST['answer_submit'])) {
		$answer = clear($_POST['answer']);
		if ($answer == "") {
			$error_answer = "Вы не ввели ответ.";
		}
		else if (strlen($answer) < 5) {
			$error_answer = "Ответ не должен быть менее 5-и символов.";
		}
		else {
			$result_answer = mysql_query("SELECT * FROM answers WHERE complaint_id='$complaint_id'");
			$row_answer = mysql_fetch_assoc($result_answer);
			if (!$row_answer) {
				mysql_query("INSERT INTO answers (complaint_id,answer) VALUES ('$complaint_id', '$answer')");
			}
			else {$error_answer = "Для этой жалобы ответ уже есть.";}
		}
	}
	// КОНЕЦ Обработка формы ответа
	// Вывод ответа для жалобы
	$result = mysql_query("SELECT * FROM answers WHERE complaint_id='$complaint_id'");
	$row = mysql_fetch_assoc($result);
	if ($row) {
		$answer = $row['answer'];
		echo "<h3>Ответ для этой жалобы.</h3>";
		echo "<p>$answer</p>";
	}
	// КОНЕЦВывод ответа для жалобы
	// Вывод формы для ответа
	else if (isset($_GET['answering'])) {
		$answering = (int) $_GET['answering'];
		if ($answering) {
			echo "<form action='' method='post' name='admin_answer_form'>
					<span class='admin_errors'>$error_answer</span><br />
					<textarea name='answer' id='answer' placeholder='Запишите ответ для жалобы сверху.'></textarea><br />
					<input type='submit' name='answer_submit' id='answer_submit' value='Отправить ответ' />
				 </form>";
		}
	}
	// КОНЕЦ Вывод формы для ответа
	else {echo "<a href='/?complaint_id=$complaint_id&answering=1' id=admin_answer_button>Ответить</a>";}
	
}
// Вывод всех жалоб отдельного пользователя
else if (isset($_GET['user_id'])) {
	$user_id = (int) $_GET['user_id'];
	// Переменная хранит число сообщений выводимых на станице  
	$num = 20;
	// Извлекаем из URL текущую страницу  
	$page = (int) $_GET['page']; 
	// Определяем общее число сообщений в базе данных 
	$result = mysql_query("SELECT COUNT(complaints.id) FROM complaints LEFT JOIN answers ON complaints.id = answers.complaint_id WHERE complaints.user_id='$user_id' AND answers.complaint_id IS NULL");  
	// $result = mysql_query("SELECT COUNT(id) FROM complaints WHERE id <> 5"); 
	$posts = mysql_result($result, 0);
	// Находим общее число страниц  
	$total = intval(($posts - 1) / $num) + 1; 
	// Если значение $page меньше единицы или отрицательно переходим на первую страницу  
	// А если слишком большое, то переходим на последнюю  
	if(empty($page) or $page < 0) $page = 1;  
 	if($page > $total) $page = $total;  
	// Вычисляем начиная с какого номера следует выводить сообщения  
	$start = $page * $num - $num;  
	// Выбираем $num сообщений начиная с номера $start  
	$result = mysql_query("SELECT complaints.id, complaints.theme, complaints.date  FROM complaints LEFT JOIN answers ON complaints.id = answers.complaint_id WHERE complaints.user_id='$user_id' AND answers.complaint_id IS NULL ORDER BY complaints.id DESC LIMIT $start, $num");
	$row = mysql_fetch_assoc($result);
	// Проверяем нужны ли стрелки назад  
	if ($page != 1) $pervpage = '<a href= ./?user_id='.$user_id.'&page=1><<</a>  
                               <a href= ./?user_id='.$user_id.'&page='. ($page - 1) .'><</a> ';  
	// Проверяем нужны ли стрелки вперед  
	if ($page != $total) $nextpage = ' <a href= ./?user_id='.$user_id.'&page='. ($page + 1) .'>></a>  
                                   <a href= ./?user_id='.$user_id.'&page=' .$total. '>>></a>';  

	// Находим две ближайшие страницы с обоих краев, если они есть  
	if($page - 2 > 0) $page2left = ' <a href= ./?user_id='.$user_id.'&page='. ($page - 2) .'>'. ($page - 2) .'</a> | ';  
	if($page - 1 > 0) $page1left = '<a href= ./?user_id='.$user_id.'&page='. ($page - 1) .'>'. ($page - 1) .'</a> | ';  
	if($page + 2 <= $total) $page2right = ' | <a href= ./?user_id='.$user_id.'&page='. ($page + 2) .'>'. ($page + 2) .'</a>';  
	if($page + 1 <= $total) $page1right = ' | <a href= ./?user_id='.$user_id.'&page='. ($page + 1) .'>'. ($page + 1) .'</a>'; 
	
	$result_user = mysql_query("SELECT login FROM users WHERE id='$user_id'");
	$row_user = mysql_fetch_assoc($result_user);
	$user = $row_user['login'];
	echo "<style>#admin_block span.admin_complaint_theme {width:65%;}</style>";
	echo "<h3>Все записи опубликованные пользователем - $user.</h3>";
	echo "<div id='admin_complaint_head'>
			<span class='admin_complaint_theme'>Тема жалобы</span>
			<span class='admin_date'>Дата</span>
			<span class='admin_answer_link'>Ответ</span>
			</div>";
	// $result = mysql_query("SELECT * FROM complaints WHERE user_id='$user_id' ORDER BY id DESC");
	// $row = mysql_fetch_assoc($result);
	do {
			printf("<div class='admin_complaint'>
						<span class='admin_complaint_theme'><a href='/?complaint_id=%d' title='Открыть текст этой жалобы'>%s</a></span>
						<span class='admin_date'>%s</span>
						<span class='admin_answer_link'><a href='/?complaint_id=%d&answering=1'>Ответить</a></span>
					</div>",$row['id'],$row['theme'],$row['date'],$row['id']);
		
	} while ($row = mysql_fetch_assoc($result));
	// Вывод меню страниц 
	if ($posts > $num) {
		echo "<div style='text-align:center;margin-top: 10px'>";
		echo $pervpage.$page2left.$page1left.'<b>'.$page.'</b>'.$page1right.$page2right.$nextpage;
		echo "</div>";
	}
}
// Вывод всех жалоб с ответами
else if (isset($_GET['is_answered'])) {
	$is_answered = TRUE;
	// Переменная хранит число сообщений выводимых на станице  
	$num = 20;
	// Извлекаем из URL текущую страницу  
	$page = (int) $_GET['page']; 
	// Определяем общее число сообщений в базе данных 
	$result = mysql_query("SELECT COUNT(complaints.id) FROM complaints RIGHT JOIN answers ON complaints.id = answers.complaint_id");  
	// $result = mysql_query("SELECT COUNT(id) FROM complaints WHERE id <> 5"); 
	$posts = mysql_result($result, 0);
	// Находим общее число страниц  
	$total = intval(($posts - 1) / $num) + 1; 
	// Если значение $page меньше единицы или отрицательно переходим на первую страницу  
	// А если слишком большое, то переходим на последнюю  
	if(empty($page) or $page < 0) $page = 1;  
 	if($page > $total) $page = $total;  
	// Вычисляем начиная с какого номера следует выводить сообщения  
	$start = $page * $num - $num;  
	// Выбираем $num сообщений начиная с номера $start  
	$result = mysql_query("SELECT complaints.id, complaints.user_id, complaints.theme, complaints.date  FROM complaints RIGHT JOIN answers ON complaints.id = answers.complaint_id ORDER BY complaints.id DESC LIMIT $start, $num");
	$row = mysql_fetch_assoc($result);
	// Проверяем нужны ли стрелки назад  
	if ($page != 1) $pervpage = '<a href= ./?is_answered&page=1><<</a>  
                               <a href= ./?is_answered&page='. ($page - 1) .'><</a> ';  
	// Проверяем нужны ли стрелки вперед  
	if ($page != $total) $nextpage = ' <a href= ./?is_answered&page='. ($page + 1) .'>></a>  
                                   <a href= ./?is_answered&page=' .$total. '>>></a>';  

	// Находим две ближайшие страницы с обоих краев, если они есть  
	if($page - 2 > 0) $page2left = ' <a href= ./?is_answered&page='. ($page - 2) .'>'. ($page - 2) .'</a> | ';  
	if($page - 1 > 0) $page1left = '<a href= ./?is_answered&page='. ($page - 1) .'>'. ($page - 1) .'</a> | ';  
	if($page + 2 <= $total) $page2right = ' | <a href= ./?is_answered&page='. ($page + 2) .'>'. ($page + 2) .'</a>';  
	if($page + 1 <= $total) $page1right = ' | <a href= ./?is_answered&page='. ($page + 1) .'>'. ($page + 1) .'</a>'; 

	echo "<style>#admin_block span.admin_complaint_theme {width:64%;}</style>";
	echo "<h2>Жалобы с ответами</h2>";
	echo "<div id='admin_complaint_head'>
			<span class='admin_complaint_theme'>Тема жалобы</span>
			<span class='admin_user'>Опубликовал</span>
			<span class='admin_date'>Дата</span>
		  </div>";
	
	do {
		$result_user = mysql_query("SELECT login FROM users WHERE id='$row[user_id]'");
		$row_user = mysql_fetch_assoc($result_user);
		$user = $row_user['login'];
		printf("<div class='admin_complaint'>
					<span class='admin_complaint_theme'><a href='/?complaint_id=%d' title='Открыть текст этой жалобы'>%s</a></span>
					<span class='admin_user'><a href='/?user_id=%d' title='Открыть все жалобы этого пользователя'>%s</a></span>
					<span class='admin_date'>%s</span>
				</div>",$row['id'],$row['theme'],$row['user_id'],$user,$row['date']);
		
	} while ($row = mysql_fetch_assoc($result));
	// Вывод меню страниц 
	if ($posts > $num) {
		echo "<div style='text-align:center;margin-top: 10px'>";
		echo $pervpage.$page2left.$page1left.'<b>'.$page.'</b>'.$page1right.$page2right.$nextpage;
		echo "</div>";
	}
}

// Вывод всех жалоб без ответов
else {
	// Переменная хранит число сообщений выводимых на станице  
	$num = 20;
	// Извлекаем из URL текущую страницу  
	$page = (int) $_GET['page']; 
	// Определяем общее число сообщений в базе данных 
	$result = mysql_query("SELECT COUNT(complaints.id) FROM complaints LEFT JOIN answers ON complaints.id = answers.complaint_id WHERE answers.complaint_id IS NULL");  
	// $result = mysql_query("SELECT COUNT(id) FROM complaints WHERE id <> 5"); 
	$posts = mysql_result($result, 0);
	// Находим общее число страниц  
	$total = intval(($posts - 1) / $num) + 1; 
	// Если значение $page меньше единицы или отрицательно переходим на первую страницу  
	// А если слишком большое, то переходим на последнюю  
	if(empty($page) or $page < 0) $page = 1;  
 	if($page > $total) $page = $total;  
	// Вычисляем начиная с какого номера следует выводить сообщения  
	$start = $page * $num - $num;  
	// Выбираем $num сообщений начиная с номера $start  
	$result = mysql_query("SELECT complaints.id, complaints.user_id, complaints.theme, complaints.date  FROM complaints LEFT JOIN answers ON complaints.id = answers.complaint_id WHERE answers.complaint_id IS NULL ORDER BY complaints.id DESC LIMIT $start, $num");
	$row = mysql_fetch_assoc($result);
	// Проверяем нужны ли стрелки назад  
	if ($page != 1) $pervpage = '<a href= ./?page=1><<</a>  
                               <a href= ./?page='. ($page - 1) .'><</a> ';  
	// Проверяем нужны ли стрелки вперед  
	if ($page != $total) $nextpage = ' <a href= ./?page='. ($page + 1) .'>></a>  
                                   <a href= ./?page=' .$total. '>>></a>';  

	// Находим две ближайшие страницы с обоих краев, если они есть  
	if($page - 2 > 0) $page2left = ' <a href= ./?page='. ($page - 2) .'>'. ($page - 2) .'</a> | ';  
	if($page - 1 > 0) $page1left = '<a href= ./?page='. ($page - 1) .'>'. ($page - 1) .'</a> | ';  
	if($page + 2 <= $total) $page2right = ' | <a href= ./?page='. ($page + 2) .'>'. ($page + 2) .'</a>';  
	if($page + 1 <= $total) $page1right = ' | <a href= ./?page='. ($page + 1) .'>'. ($page + 1) .'</a>'; 

	echo "<h2>Жалобы без ответов</h2>";
	echo "<div id='admin_complaint_head'>
			<span class='admin_complaint_theme'>Тема жалобы</span>
			<span class='admin_user'>Опубликовал</span>
			<span class='admin_date'>Дата</span>
			<span class='admin_answer_link'>Ответ</span>
		  </div>";
	
	do {
		$result_user = mysql_query("SELECT login FROM users WHERE id='$row[user_id]'");
		$row_user = mysql_fetch_assoc($result_user);
		$user = $row_user['login'];
		printf("<div class='admin_complaint'>
					<span class='admin_complaint_theme'><a href='/?complaint_id=%d' title='Открыть текст этой жалобы'>%s</a></span>
					<span class='admin_user'><a href='/?user_id=%d' title='Открыть все жалобы этого пользователя'>%s</a></span>
					<span class='admin_date'>%s</span>
					<span class='admin_answer_link'><a href='/?complaint_id=%d&answering=1'>Ответить</a></span>
				</div>",$row['id'],$row['theme'],$row['user_id'],$user,$row['date'],$row['id']);
		
	} while ($row = mysql_fetch_assoc($result));
	// Вывод меню страниц 
	if ($posts > $num) {
		echo "<div style='text-align:center;margin-top: 10px'>";
		echo $pervpage.$page2left.$page1left.'<b>'.$page.'</b>'.$page1right.$page2right.$nextpage;
		echo "</div>";
	}
}
?>

</div>
<!-- Админская часть -->
<?php
	}
}
?>