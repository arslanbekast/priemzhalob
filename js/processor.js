$(document).ready(readyDoc);

function readyDoc() {
	$("#reg").click(function(){
		reloadCaptcha();
		$("#error_login,#error_pass,#error_captcha").html("");
		$("#login,#pass,#captcha").val("").css("background","");
		$("#button").hide();
		$("#reg_button").show();
		$("#vhod").css("background","#505050");
		$("#reg").css("background","#e70202");
		$("#vhod_reg_forms").css("width","0").animate({width:"70%"});
	});
	$("#vhod").click(function(){	
		reloadCaptcha();
		$("#error_login,#error_pass,#error_captcha").html("");
		$("#login,#pass,#captcha").val("").css("background","");
		$("#reg_button").hide();
		$("#button").show();
		$("#vhod").css("background","#e70202");
		$("#reg").css("background","#505050");
		$("#vhod_reg_forms").css("width","0").animate({width:"70%"});
	});

	$("#button").click(login);
	$("#reg_button").click(signup);
	$("#complaint_submit").click(complaintSubmit);
	$("#reset").click(function(){$("#complaint_theme,#complaint_text,#captcha").val("");});
}

// Обработка входа
function login() {
	validate();
	if (!errorLogin && !errorPass && !errorCaptcha) {
		$.ajax({
 			type: "POST",
 			url: "processor.php",
 			data: {submit:1,login:login,pass:pass,captcha:captcha,res_captcha:resCaptcha},
 			beforeSend: function() {
 				$("#button").html("<img src='img/vhod_reg_button.GIF' width=220 height=20 />");
 			},
 			success: function(data) {
 				if (data == 1) {
 					location.reload();
 				}
 				else {
 					reloadCaptcha();
 					$("#captcha").val("");
 					$("#button").html("Войти");
 					$("#login").css("background","antiquewhite");
 					$("#error_login").html(data).fadeIn(300);
 				}
 			}
 		});
	}
}

// Обработка регистрации
function signup() {
	validate();
	if (!errorLogin && !errorPass && !errorCaptcha) {
		$.ajax({
 			type: "POST",
 			url: "processor.php",
 			data: {reg:1,login:login,pass:pass,captcha:captcha,res_captcha:resCaptcha},
 			beforeSend: function() {
 				$("#reg_button").html("<img src='img/vhod_reg_button.GIF' width=220 height=20 />");
 			},
 			success: function(data) {
 				if (data == 1) {
 					location.reload();
 				}
 				else {
 					reloadCaptcha();
 					$("#captcha").val("");
 					$("#reg_button").html("Зарегистрировать");
 					$("#login").css("background","antiquewhite");
 					$("#error_login").html(data).fadeIn(300);
 				}
 			}
 		});
	}
}

// Проверка введенных данных при входе/регистрации
function validate() {
	login = $('#login').val();
	pass = $('#pass').val();
	captcha = $('#captcha').val();
	resCaptcha = $('#res_captcha').val();
	errorLogin = true;
	errorPass = true;
	errorCaptcha = true;
	$("#login").focus(function(){
			$("#error_login").html("").hide();
			$("#login").css("background","#fff");
		});
	$("#pass").focus(function(){
			$("#error_pass").html("").hide();
			$("#pass").css("background","#fff");
		});
	$("#captcha").focus(function(){
			$("#error_captcha").html("").hide();
			$("#captcha").css("background","#fff").val("");
		});

	if (login == '') {
		$("#error_login").html("Вы не ввели логин.").fadeIn(300);
		$("#login").css("background","antiquewhite");
	}
	else if (login.length < 4 || login.length > 30) {
		$("#error_login").html("Логин должен быть не меньше 4-х символов и не больше 30.").fadeIn(300);
		$("#login").css("background","antiquewhite");
	}
	else if (/[^A-Za-z0-9-_]/.test(login)) {
		$("#error_login").html("Логин может содержать только буквы латинского алфавита, цифры, дефис и знак подчеркивания.").fadeIn(300);
		$("#login").css("background","antiquewhite");
	}
	else if (!/[A-Za-z]/.test(login.charAt(0))) {
		$("#error_login").html("Логин должен начинаться с буквы.").fadeIn(300);
		$("#login").css("background","antiquewhite");
	}
	else {errorLogin = false;}
	if (pass == '') {
		$("#error_pass").html("Вы не ввели пароль.").fadeIn(300);
		$("#pass").css("background","antiquewhite");
		
	}
	else if (pass.length < 4 || pass.length > 30) {
		$("#error_pass").html("Пароль должен быть не меньше 4-х символов и не больше 30.").fadeIn(300);
		$("#pass").css("background","antiquewhite");
	}
	else if (/[А-Яа-я]/.test(pass)) {
		$("#error_pass").html("Пароль не должен содержать русские символы.").fadeIn(300);
		$("#pass").css("background","antiquewhite");
	}
	else {errorPass = false;}
	if (captcha == '') {
		$("#error_captcha").html("Вы не ввели ответ.").fadeIn(300);
		$("#captcha").css("background","antiquewhite");
		
	}
	else if (captcha != resCaptcha) {
		$("#error_captcha").html("Вы ввели неверный ответ.").fadeIn(300);
		$("#captcha").css("background","antiquewhite");
	}
	else {errorCaptcha = false;}
}

// Обработка жалобы
function complaintSubmit() {
	var complaintTheme = $("#complaint_theme").val();
	var complaintText = $("#complaint_text").val();
	var captcha = $("#captcha").val();
	var resCaptcha = $("#res_captcha").val();
	var errorComplaintTheme = true;
	var errorComplaintText = true;
	var errorCaptcha = true;

	$("#complaint_theme").focus(function(){
			$("#error_complaint_theme").html("").hide();
			$(this).css("background","#fff");
		});
	$("#complaint_text").focus(function(){
			$("#error_complaint_text").html("").hide();
			$(this).css("background","#fff");
		});
	$("#captcha").focus(function(){
			$("#error_captcha").html("").hide();
			$("#captcha").css("background","#fff").val("");
		});

	if (complaintTheme == "") {
		$("#error_complaint_theme").html("Вы не ввели тему жалобы или просьбы.").fadeIn(300);
		$("#complaint_theme").css("background", "antiquewhite");
	}
	else if (complaintTheme.length < 4) {
		$("#error_complaint_theme").html("Тема должна содержать не меньше 4-х символов.").fadeIn(300);
		$("#complaint_theme").css("background", "antiquewhite");
	}
	else {errorComplaintTheme = false;}

	if (complaintText == "") {
		$("#error_complaint_text").html("Вы не ввели текст жалобы или просьбы.").fadeIn(300);
		$("#complaint_text").css("background", "antiquewhite");
	}
	else if (complaintText.length < 5) {
		$("#error_complaint_text").html("Текст должен содержать не меньше 5-и символов.").fadeIn(300);
		$("#complaint_text").css("background", "antiquewhite");
	}
	else {errorComplaintText = false;}

	if (captcha == "") {
		$("#error_captcha").html("Вы не ввели ответ.").fadeIn(300);
		$("#captcha").css("background","antiquewhite");
		
	}
	else if (captcha != resCaptcha) {
		$("#error_captcha").html("Вы ввели неверный ответ.").fadeIn(300);
		$("#captcha").css("background","antiquewhite");
	}
	else {errorCaptcha = false;}

	if (!errorComplaintTheme && !errorComplaintText && !errorCaptcha) {
		$.ajax({
 			type: "POST",
 			url: "processor.php",
 			data: {complaint_submit:1,complaint_theme:complaintTheme,complaint_text:complaintText,captcha:captcha,res_captcha:resCaptcha},
 			beforeSend: function() {
 				$("#complaint_submit").css("background","#e70202").html("<img src='img/vhod_reg_button.GIF' width=195 height=17 />");
 			},
 			success: function(data) {
 				$("#complaint_theme,#complaint_text,#captcha").val("");
 				reloadCaptcha();
 				$("#complaint_submit").css("background","").html("Отправить");
 				$("#system_info_text").text(data);
 				$("#system_info_block").css("display","block");
 				$("#system_info").animate({marginTop:"250px"},500);
 				$("#system_info_ok").click(function(){
 					$("#system_info").animate({marginTop:"-999px"},500,function(){$("#system_info_block").css("display","none");});
 				});
 			}
 		});
	}
}

// Обновление капчи
function reloadCaptcha() {
	$.ajax({
 			type: "POST",
 			url: "processor.php",
 			data: {reload_captcha:1},
 			beforeSend: function() {
 				$(".captcha").html("<img src='img/reload_captcha.GIF' />");
 			},
 			success: function(data) {
 					data = JSON.parse(data);
 					var reload_captcha = data['captcha'];
 					var reload_res_captcha = data['res_captcha'];
 					$(".captcha").html(reload_captcha);
 					$("#res_captcha").val(reload_res_captcha);
 			}
 		});
}

// Проверка существования ответа для жалобы пользователя
function isAnswer() {
	$.ajax({
 			type: "POST",
 			url: "processor.php",
 			data: {is_answer:1},
 			success: function(data) {
 				if (data != 0) {
 					var data = JSON.parse(data);
 					for (i=0; i < data.length; i++) {
 						$("#is_answer").append("<div class='answer_block'><h4>"+data[i]['theme']+"</h4><p>"+data[i]['complaint']+"</p><a href='#' id='slide_answer"+data[i]['id']+"' onclick='return false;'><span>Показать</span> ответ</a><p class='answer' id='answer"+data[i]['id']+"'></p><script>$('#slide_answer"+data[i]['id']+"').click(function(){getAnswer("+data[i]['id']+");});</script></div>"); 
 					}
 					$("#is_answer_block").fadeIn(400);
 					$("#is_answer").css("display","block").animate({top:"0"},800);
 					$("#answer_close").click(function(){
 						$("#is_answer").animate({top:"-9999px"},800,function(){
 							$(this).hide();
 						});
 						$("#is_answer_block").fadeOut(400);
 					});
 					
 				}

 			}
 		});
}

// Получение ответа для жалобы
function getAnswer(complaint_id) {
	var complaint_id = complaint_id;
	$.ajax({
 			type: "POST",
 			url: "processor.php",
 			data: {get_answer:1,complaint_id:complaint_id},
 			beforeSend: function() {
 				$("#answer"+complaint_id).html("<img src='img/load_answer.gif' width='32' height='32' />");
 			},
 			success: function(data) {
 				$("#slide_answer"+complaint_id).unbind('click');
 				$("#answer"+complaint_id).html(data);
 				$("#slide_answer"+complaint_id).addClass("slide_answer");
 				$("#slide_answer"+complaint_id).click(function(){
 					$("#answer"+complaint_id).slideToggle(300);
 					$(this).toggleClass("slide_answer");
 				});
 			}
 		});
}