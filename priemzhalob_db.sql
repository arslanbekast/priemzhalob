-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Сен 11 2015 г., 16:16
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `pomogite_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `admin`
--

INSERT INTO `admin` (`id`, `user_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `answers`
--

CREATE TABLE IF NOT EXISTS `answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  `user_read` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `answers`
--

INSERT INTO `answers` (`id`, `complaint_id`, `answer`, `user_read`) VALUES
(1, 11, 'Ответ для этой жалобы очень хороший.', 0),
(2, 10, 'Ответ для жалобы "Почему кнопка Win вовсе не лишняя?"', 0),
(3, 9, 'xzvsxvsdgvsfgfdgdfg d gfd fgd fg', 0),
(4, 15, 'axsdasdasfda', 0),
(5, 8, 'xcvdfgbdf', 1),
(6, 7, 'fdvdfbdfbdbf', 1),
(7, 6, 'dvsdfgsdfsd', 0),
(8, 12, 'dfbdfbdfb', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `complaints`
--

CREATE TABLE IF NOT EXISTS `complaints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `theme` varchar(255) NOT NULL,
  `complaint` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Дамп данных таблицы `complaints`
--

INSERT INTO `complaints` (`id`, `user_id`, `theme`, `complaint`, `date`) VALUES
(1, 1, 'Что мы узнали благодаря американскому кино:', '1. Вентиляционная система любого здания &mdash; превосходное укрытие. Никто и не подумает искать вас там и вы смело можете добраться по ней до любой точки здания.\n\n2. Если кого-то покалечило взрывом, то у него обязательно нужно спросить "Ты в порядке?"\n\n3. Независимо от того, насколько сильно пострадал космический корабль, его внутренняя гравитационная система никогда не повреждена.\n\n4. Телевизионные новости, как правило, передают выпуск, который затрагивает вас лично в тот самый момент, когда вы включаете телевизор.\n\n5. Независимо от того, насколько нечеткая\nфотография, ее можно увеличить и рассмотреть до мельчайших деталей.\n\n6. Чтобы уничтожить данные в компьютере, достаточно просто выстрелить в монитор.\n\n7. Если эксперт делает прогноз и ему не верят &ndash; сбудется все именно так, как он предсказал. Если верят &ndash; этого никогда не случится.\n\n8. Во всех бомбах встроены электронные счетчики времени с большим красным табло, так что вы всегда точно знаете, когда они взорвутся.\n\n9. Губная помада никогда не сотрется, даже если вы ныряете с аквалангом.\n\n10. Если в фильме есть второстепенный герой и темный подвал, в который не стоит входить, то этот герой обязательно зайдет туда, чтобы задать там идиотский вопрос &laquo;кто там?&raquo; и получить по голове.\n\n11. Если что-то излучает радиацию, оно непременно светится зеленым светом.\n\n12. Любой человек, проснувшийся от кошмара, резко садится и начинает тяжело дышать.\n\n13. Находясь в доме с привидениями, женщина должна исследовать любой источник странных шумов, надев свое самое откровенное нижнее белье.\n\n14. Нет никакой разницы, сколько противников у вас в драке. Ваши враги будут терпеливо ждать, танцуя вокруг, пока вы не отправите их всех по одному в нокаут.\n\n15. Перед тем, как выпустить пулю в героя, злодей обязательно несколько минут читает ему нотацию.\n\n16. Поиск в Интернете всегда дает вам именно то, что вы искали, прямо на первой странице.\n\n17. В фильмах ужасов в живых почти всегда остаются парень и девушка, которые страстно целуются или занимаются сексом. Несмотря на то, что только что маньяк перерезал всех их друзей.\n\n18. Чем сильнее мужчина и женщина ненавидят друг друга, тем больше вероятность того, что они влюбятся к концу фильма.\n\n19. Шестизарядные пистолеты стреляют по 30&ndash;40 раз.\n\n20. Эйфелева башня видна из любого окна в Париже.\n\n21. Если герой попал в драку, то он однозначно выйдет из нее с маленьким рассечением в правом уголке рта. Он обязательно вытрет кровь обратной стороной ладони и неодобрительно посмотрит.\n\n22. Во время полицейской слежки, действие всегда начинается тогда, когда будет куплен гамбургер, а чашка с обжигающе горячим кофе предусмотрительно займет место на торпеде полицейского автомобиля.\n\n23. Любое спортивное состязание будет выиграно полным неудачником на последней секунде.\n\n24. Все бомбы имеют провода разных цветов, чтобы герой мог с легкостью определить какой именно провод нужно резать.\n\n25. Если отказали тормоза в машине, водитель никогда не использует ручной тормоз или торможение двигателем &mdash; он продолжит мчаться на огромной скорости по городу.\n\n26. Все вещи пуленепробиваемые &mdash; машины, столы, тела, кухонные доски.\n\n27. Все полицейские службы имеют нескончаемый запас полицейских машин. У них также самые невезучие водители, которые бьются в лобовых столкновениях, врезаются в припаркованные машины, падают в воду и конечно же взлетают в воздух, входят в штопор, приземляются на крышу, ломают мигалки, которые издают звук, словно у них садятся батарейки.', '2015-09-08 07:33:26'),
(2, 2, '9 книг, которые читаются за одну ночь', 'Держать читателя в постоянном напряжении и при этом рассказывать по-настоящему достойную историю &mdash; искусство, которым владеет далеко не каждый писатель. Но существуют такие книги, которые при небольшом объеме способны увлечь настолько, что весь мир отходит на второй план.\n1. Диана Сеттерфилд - Тринадцатая сказка\nГотическая история, в которой есть старинное мрачное поместье, семейные тайны, призраки, хитросплетение судеб и ощущение недосказанности, захватывает и не отпускает, пока не будет прочитана последняя страница. В этом романе прекрасно все: сюжет, атмосфера, характеры, язык и изысканный стиль. Бессонная ночь гарантирована.\n\n2. Иэн Макьюэн - Амстердам\nДвое друзей &mdash; преуспевающий главный редактор популярной ежедневной газеты и знаменитый композитор, работающий над &laquo;Симфонией тысячелетия&raquo;, &mdash; заключают соглашение об эвтаназии: если один из них впадет в состояние беспамятства и перестанет себя контролировать, то другой обязуется его убить... Изящный, завораживающий роман о том, как легко человек способен разрушить все вокруг себя.\n\n3. Дуглас Адамс - Автостопом по галактике\nКнига, которая огорошивает и ошарашивает с первых же страниц. Наверное, настоящее путешествие по галактике именно таким и должно быть &mdash; с невероятными приключениями и неправдоподобными ситуациями, с тоннами юмора и сарказма. В общем, путешествуйте автостопом и читайте Адамса.\n\n4. Джон Фаулз - Коллекционер\nОдинокий недалекий молодой человек неожиданно выигрывает огромную сумму денег в лотерею. Что он с ней сделает, особенно если учитывать его страсть к коллекционированию бабочек и тайную любовь к местной красавице? В истории противостояния маньяка и его жертвы Фаулз увидел противоборство Добра и Зла, примитивного обывателя и возвышенного художника, Любви, Смерти и Красоты.\n\n5. Виктор Пелевин - Омон Ра\n&laquo;Омон Ра&raquo; &mdash; это жуткая история о том, как кровавый советский режим запускал в космос корабли на человеческой тяге, а происходило это в действительности или...\nПо мнению одного из собратьев по перу, Пелевина можно читать с начала, с середины, с конца &mdash; как священное писание. Очень точно подмечено. И этот небольшой роман точно не оставит вас равнодушным, мы обещаем.\n\n6. Джейн Остен - Гордость и предубеждение\nЭто роман в традиционном понимании слова &mdash; не женский, не любовный, а просто классический, вечный, искренний роман. И так трудно вернуться из старой доброй Англии с ее эпичными страстями и уютными интерьерами в нашу серую шумную современность, что хочется остаться в нем навсегда. Как и в любой хорошей книге.\n\n7. Дэниел Киз - Множественные умы Билли Миллигана\nБилли просыпается и обнаруживает, что находится в тюремной камере. Ему сообщают, что он обвиняется в изнасиловании и ограблении. Билли потрясен: он ничего этого не делал! Последнее, что он помнит, &mdash; это как хотел броситься вниз с крыши здания школы. Ему говорят, что с тех пор прошло семь лет.\n\n8. Наринэ Абгарян - Манюня\n&laquo;Манюня&raquo; &mdash; светлый, пропитанный солнцем и запахами южного базара и потрясающе смешной рассказ о детстве, о двух девочках-подружках Наре и Манюне, о грозной и доброй Ба - бабушке Манюни, и о куче их родственников, постоянно попадающих в казусные ситуации. Это то самое теплое, озорное и полное веселых приключений детство, которое делает человека счастливым на всю жизнь.\n\n9. Габриэль Гарсиа Маркес - Вспоминая моих грустных шлюх\nОдна из тех книг, которые выбрасывают вас из реальности и заставляют спрашивать: &laquo;Что это было?&raquo;. Пронзительная, грустная, атмосферная история жизни и любви &mdash; случайной любви, ненастоящей любви, поздней, последней и самой гибельной любви, которая позволяет человеку хотя бы на мгновение увидеть мир таким, каков он есть.', '2015-09-08 08:33:14'),
(3, 2, '52 комбинации на клавиатуре, которые помогут облегчить Вашу жизнь!', 'Firefox\n- Поднять или опустить страницу: Пробел &ndash; опустить страницу, Shift пробел &ndash; поднять страницу.\n\n- Найти: Ctrl F или Alt-N для следующей страницы.\n\n- Добавить страницу в закладки: Ctrl D.\n\n- Быстрый поиск:/.\n\n- Новая вкладка: Ctrl T.\n\n- Перейти на панель поиска: Ctrl K.\n\n- Перейти в адресную строку: Ctrl L.\n\n- Увеличить размер текста: Ctrl =. Уменьшить размер текста Ctrl -\n\n- Закрыть вкладку: Ctrl-W.\n\n- Обновить страницу: F5.\n\n- Перейти на домашнюю страницу: Alt-Home.\n\n- Восстановить закрытую страницу: Ctrl Shift T.\n\n- Закладки по ключевым словам - это наиболее продуктивно! Если вы часто заходите на сайт, вы делаете закладку (конечно!), затем переходите к свойствам закладок (щёлкните по ним правой кнопкой мыши). Добавьте короткое ключевое слово в строку ввода ключевых слов, сохраните, и после этого вы можете просто вводить в адресную строку (Ctrl L) это ключевое слово и сразу же переходить на сайт.\n\nGmail\n- Написать новое письмо: C.\n\n- Ответить на письмо: R.\n\n- Ответить всем: A.\n\n- Переслать письмо: F.\n\n- Сохранить текущее письмо и открыть следующее письмо: Y O.\n\n- Удалить письмо и открыть следующее: # O (или Shift-3 O).\n\n- Отправить написанное письмо: Tab-Enter.\n\n- Поиск: /.\n\n- Навигация: Перемещение вниз J и вверх K по списку контактов.\n\n- Список сообщений: N и P передвигают курсор на следующее или предыдущее сообщение в списке сообщений.\n\n- Игнорировать: M &ndash; письма с отмеченными адресами перестают попадать в список входящих писем и архивируются.\n\n- Выбрать цепочку писем. X &ndash; цепочка писем будет выбрана. Её можно заархивировать, применить к ней ярлык и выбрать для неё действие.\n\n- Сохранить черновик: Control-S.\n\n- Перейти к списку сообщений: G I.\n\n- Перейти к помеченным письмам: G S.\n\n- Перейти к адресной книге: G C.\n\nWindows\n- Создание комбинаций клавиш быстрого переключения. Для того, чтобы создать комбинации клавиш для быстрого переключения, щёлкните правой кнопкой мыши по иконке создания клавиш быстрого переключения (такая есть на вашем рабочем столе) и введите комбинацию. Например, такую как Ctrl-Alt-W для программы Word.\n\n- Переключение между окнами. Alt-Tab &ndash; выберете нужное окно, после этого опустите клавиши. Или удерживайте клавишу Windows, нажмите на Tab для того, чтобы пройтись по кнопкам на панели задач и найти нужное окно, затем, найдя его, нажмите Enter. Если добавить кнопку Shift к любому из этих методов, выбор окон будет осуществляться в обратном направлении.\n\n- Перейти на рабочий стол: клавиша Windows-D.\n\n- Контекстное меню. Вместо того, чтобы щёлкать правой кнопкой мыши, нажмите Shift-F10. Затем прокрутите меню вверх или вниз при помощи клавиш со стрелками вверх и вниз.\n\n- Выключение. Для того, чтобы быстро выключить компьютер, нажмите клавишу Windows, а затем U. С этой клавишей вы также можете нажать на S для паузы, на U для выключения или на R для перезагрузки.\n\n- Наиболее общее. Вы это, конечно, знаете, но для новичков нужно упомянуть наиболее известные комбинации: Ctrl-O &ndash; открыть, Ctrl-S &ndash; сохранить, Ctrl-N &ndash; открыть новый документ, Ctrl-W &ndash; закрыть окно, Ctrl-C &ndash; копировать, Ctrl-V &ndash; вставить, Ctrl-X &ndash; вырезать. Ctrl-Z &ndash; отменить (назад), Ctrl-Y &ndash; отменить (вперёд). Для того, чтобы увидеть содержание буфера обмена в MS Office, нажмите Ctrl-C дважды. Ctrl-Home &ndash; перейти к началу документа, Ctrl-End &ndash; перейти к концу.\n\n- Меню. Когда вы нажимаете Alt, появляется меню, в котором нужно работать, используя кнопки со стрелками. Alt плюс подчёркнутая буква каждой опции меню ведёт к использованию этой опции или просто запоминает комбинацию клавиш для этой опции для ещё более быстрого использования.\n\n- Проводник Windows (Explorer). Windows-E &ndash; запускается программа Мой компьютер.\n\nОперационная система Mac\n- Переключение Dock: Option-Cmd-D &ndash; показать/спрятать Dock.\n\n- Спрятать всё остальное: Cmd-Option-H прячет все остальные окна кроме того, в котором вы находитесь. Это облегчает ваш экран.\n\n- Закрыть окно: Cmd-W закрывает активное открытое окно. Option-Cmd-W закрывает все открытые окна.\n\n- Развернуть каталог: Option-Cmd-стрелка вправо &ndash; развернуть каталог и подкаталоги в списке в Finder.\n\n- Вперёд и назад: Cmd-[ andCmd-] работает с программами Finder, Safari и Firefox.\n\n- Копировать экран: Cmd-Shift-3 &ndash; для всего экрана. Cmd-Shift-4 &ndash; создает границы для копирования выбранной части экрана.\n\n- Выход: Shift-Cmd-Q &ndash; выход осуществится через 2 минуты. Shift-Option-Cmd-Q &ndash; выход осуществится немедленно.\n\n- Очистить корзину: Shift-Cmd-Delete.\n\n- Новое окно в Safari: Cmd-T.\n\n- Помощь: Cmd-shift-?.\n\n- Загрузка CD. Нажмите C и во время запуска (сразу после мелодии) загрузите CD.\n\n- Загрузиться из другого отдела. Option-Cmd-Shift-Delete &ndash; начнёт начальную загрузку, пока не будет найден другой отдел, такой как CD или диск.\n\n- Дополнительная информация. Cmd-Option-I открывает окно с дополнительной информацией, которая позволяет вам увидеть и сравнить в одном окне много файлов и папок.\n\n- Спящий режим, перезагрузка и выключение. Cmd-option-eject, Cmd-ctrl-eject и Cmd-Option-ctrl-eject.\n\n- Принудительное выключение: Cmd-opt-Esc.', '2015-09-08 08:33:48'),
(4, 2, '15 простых правил для быстрого прорыва в жизни: (просматривайте этот список иногда)', '1. Не смотрите телевизор. Никогда.\n\n2. Не возвращайтесь к людям, которые вас предали. Они не меняются.\n\n3. Пришла в голову идея? Запишите. Когда-то она вам пригодиться!\n\n4. Опаздываете? Найдите способ предупредить об этом. Это не так сложно.\n\n5. Не смейтесь над чужими мечтами. Подумайте над своими.\n\n6. Говорите правду, и тогда не придется ничего запоминать.\n\n7. Не распространяйте сплетни. Ни к чему хорошему они не приведут.\n\n8. Вежливость покоряет города. Пользуйтесь почаще, господа.\n\n9. Умейте признавать свои ошибки.\n\n10. Откажитесь от привычки всё время жаловаться. Никого не интересуют чужие проблемы.\n\n11. Есть такая штука как &laquo;Двигаться дальше несмотря ни на что&raquo;. Попробуйте, поможет.\n\n12. В непонятных ситуациях всегда ложитесь спать. Также в любых ситуациях полезно помнить, что "и это пройдет".\n\n13. Даже при серьёзной ссоре не пытайтесь задеть человека за живое... Вы помиритесь (скорее всего), а слова запомнятся надолго...\n\n14. В начале дня делайте самое трудное и неприятное дело.\nКогда вы сделали его &mdash; остаток дня вас не одолевают ненужные мысли.\n\n15. Никто никому ничего не должен. Забудьте слово "должен". Выбросьте из активного лексикона. Иначе действительно увязнете в долгах, да не только материальных, а ещё и моральных.', '2015-09-08 08:34:16'),
(5, 2, '19 лучших цитат из кино и сериалов, над которыми стоит задуматься', '1. Не позволяй никому, никогда, заставлять тебя чувствовать, что ты не заслуживаешь того, что хочешь.\nХит Леджер\n\n2. Они научили меня ценить верность&hellip; и никогда не забывать о тех, кого любишь.\nХатико: Самый верный друг\n\n3. Мы ходим на работу, которую ненавидим, чтобы купить вещи, которые нам не нужны.\nБойцовский клуб\n\n4. Я всегда всю личную жизнь откладывала на потом, но и подумать не могла, что это, потом, может не наступить!\nМежду небом и землей\n\n5. &ndash; А жизнь &ndash; всегда такое дерьмо, или только в детстве?\n&mdash; Всегда.\nЛеон\n\n6. &ndash; Я сошёл с ума.\n&ndash; Боюсь, что да. Совершенно свихнулся, но открою тебе секрет: безумцы всех умней.\nАлиса в стране чудес\n\n7. Сложно не принять решение, а пережить последствия.\nЗаконопослушный гражданин\n\n8. &ndash; Не совершай классическую ошибку всех умников: не думай, что нет людей умнее тебя.\nОбласти тьмы\n\n9. Если человек искренне раскаивается в своих грехах, он может вернуться в то время, которое было самым счастливым для него, и остаться там навсегда. Может, это и есть рай.\nЗеленая миля\n\n10. &ndash; Ты либо псих, либо гений.\n&mdash; Это две крайности одной и той же сущности.\nПираты Карибского Моря\n\n11. У человека две стороны: хорошая и плохая; прошлое и будущее. В любимом человеке надо принимать обе стороны.\nТурист\n\n12. Иногда, лучше молчать и казаться идиотом, чем открыть рот &ndash; и доказать это.\nСверхъестественное\n\n13. Если не знаешь, чего хочешь, умрешь в куче того, чего не хотел.\nБойцовский клуб\n\n14. Жизнь измеряется не количеством сделанных вдохов и выдохов, а количеством тех моментов, когда от счастья захватывает дух.\nПравила Съема: Метод Хитча\n\n15. Мои понятия весьма просты:\nХочешь похудеть &ndash; перестань много жрать.\nХочешь заработать &ndash; оторви свою задницу и работай.\nХочешь быть счастливым &ndash; найди того, кто тебе нравится и не отпускай его.\nСекс по дружбе\n\n16. У меня нет времени. У меня нет времени беспокоиться из-за того, как это произошло. Произошло &ndash; и произошло.\nВремя\n\n17. Безумен тот, кто, не умея управлять собой, хочет управлять другими.\nДжокер\n\n18. У каждого свой ад &ndash; это не обязательно огонь и смола! Наш ад &ndash; это жизнь впустую!\nКуда приводят мечты\n\n19. Страх делает тебя пленником. Надежда дает тебе свободу.\nПобег из Шоушенка', '2015-09-08 08:35:34'),
(6, 2, 'Самозванец выдал себя за хирурга и вылечил 15 человек из 16', 'Человека на этой фотографии зовут Фердинанд Уолдо Демара, но также он известен как "Великий самозванец". Почему его так назвали?\n\nВыдавал себя за бенедектинского монаха, директора тюрьмы, судового врача, эксперта по уходу за ребенком, инженера-строителя, заместителя шерифа, дипломированного психолога, адвоката, санитара, учителя, редактора и ученого, ищущего лекарства от рака. Но никогда не старался заработать на этом. Все, что ему было нужно &ndash; уважение окружающих. Обладал фотографической памятью и высоким IQ.\n\nВ 16 лет сбежал из дома и провел несколько лет с монахами-цистерцианцами, а в 1941 записался в армию. Потом - во флот. Пытался выдать себя за офицера, а когда это не удалось, инсценировал самоубийство и превратился в Роберта Линтона Френча, психолога с религиозным уклоном. Преподавал психологию в колледжах Пенсильвании и Вашингтона.\n\nПотом на него вышли агенты ФБР и Демара получил 18 месяцев тюрьмы за дезертирство. После освобождения он купил поддельные документы и изучал право в Северо-Восточном университете, а затем снова ушел в монахи. Основал колледж, который существует до сих пор. В церкви он познакомился с молодым врачом Джозефом Сирой, воспользовался его именем и начал выдавать себя за хирурга. Во время корейской войны он получил звание лейтенанта, должность судового врача на канадском эсминце "Каюга" и был отправлен в Корею. Там прекрасно лечил больных с помощью пенициллина.\n\nОднажды на эсминец доставили 16 тяжелораненых солдат, которым нужна была операция. Демара был единственным хирургом на корабле. Он велел персоналу подготовить раненых и отвезти их в операционную, а сам засел в своей каюте с учебником по хирургии. Демара самостоятельно провел все операции (в том числе несколько тяжелых). И у него не умер ни один солдат. О нем восторженно писали газеты. Случайно их прочла мать настоящего Джозефа Сиры - и обман открылся. Капитан долго отказывался верить в то, что его хирург не имел никакого отношения к медицине. ВМС Канады решили не выдвигать обвинений против Демары, и тот вернулся в Соединенные Штаты.\n\nПотом он еще работал заместителем начальника тюрьмы в Техасе (его взяли благодаря диплому психолога). Там Демара затеял серьезную программу психологической перековки преступников - и преуспел в этом. Работал консультантом в крупнейшем лос-анджелесском приюте для бездомных, получил сертификат об окончании колледжа в Орегоне и был приходским священником при больнице.\n\nВ 1982 году умер от сердечной недостаточности. О нем было написано несколько книг и снят фильм и сериал.', '2015-09-08 09:21:08'),
(7, 2, 'Самые необычные памятники в мире', 'Все мы видели традиционные и исторические памятникi, которыe порой вызывают тоску и однообразие. В каждом городе мы могли видеть одинаковых дедушек Лениных в кепках, указывающих нам наш путь и одинаковых задумчивых Пушкиных. Не помню, чтобы мой взгляд радовали эти скульптуры. Думаю, что и ваш тоже. Но сейчас все чаще встречаются весьма оригинальные, и экстравагантные статуи по всему миру. И порой не сразу поймешь, что же этим хотел сказать художник. А они бывает, не ограничивают себя формальностями и стандартами.', '2015-09-08 09:32:24'),
(8, 2, 'Собака Стаффорд спасла ребёнка', 'Жила в одной семье Стаффорд по кличке Нэнни. Она была настоящей всеобщей любимицей. Знала и выполняла огромное колличество команд. Собака была семейной гордостью.\n\nВ один прекрасный день в доме появился малыш. Нэнни обожала его. Смотрела на человеческое дитя влюблёнными глазами. Постоянно старалась находиться возле детской кроватки, словно охраняла малыша.\n\nВскоре у самой Нэнни появились щенки. Собака прям разрывалась между своими собственными отпрысками и человеческим. Стаффорд всё также уделяла малышу внимание, не обходила его своим теплом и лаской. Обожание собаки превратило в недоумении дальних знакомых семьи: &laquo;Как так получается, ведь Стаффорды &mdash; это собаки убийцы?!&raquo;. А некоторые просто завидовали. Не каждый владелец собаки (независимо от породы пса) может похвастаться четвероногой нянькой &mdash; защитницей.\n\nОднажды счастье семьи прервалось. Ночью в доме вспыхнул пожар. К сожалению пожарные приехали поздно. В доме остались младенец и Нэнни со щенками.\n\nУбитые горем родители понимали, что никто из спасателей не пойдёт в эпицентр пламени спасать их ребёнка. Они хотели сами пробраться в здание, но их остановили. Неожиданно из дома появилась Нэнни с ребенком в зубах. Между спасением человеческого дитя и своих собственных, она выбрала первое. Отдав ребенка родителям, Нэнни кинулась обратно, за своими щенками, но больше не вернулась&hellip;', '2015-09-08 09:33:19'),
(9, 2, 'Процессор AMD Athlon X4 880K будет работать на частоте 4 ГГц', 'Флагманским процессором AMD в исполнении FM2+ является модель Athlon X4 870K. Данный CPU располагает четырьмя ядрами архитектуры Steamroller, функционирующими на частоте 3,9 ГГц.\n\nКак это часто бывает, благодаря списку поддерживаемых решений какой-нибудь системной платы (в данном случае это Biostar A58MD), мы теперь знаем, что AMD выпустит модель Athlon X4 880K.\n\nОтличие от CPU Athlon X4 870K будет лишь одно &mdash; увеличенная до 4 ГГц частота. TDP при этом останется равным 95 Вт. О сроках появления и стоимости новинки данных пока нет. Нынешний флагман линейки в США сейчас доступен по цене около $80.', '2015-09-08 09:34:40'),
(10, 3, 'Почему кнопка Win вовсе не лишняя?', '22 полезные функции\n\nВозможности клавиши Win далеко выходят за рамки простого вызова меню Start. C ее помощью можно вызывать самые разные системные утилиты, управлять окнами, блокировать компьютер и многое другое.\n\nОсобенно актуально освежить знания об этих горячих клавишах в связи с грядущим выходом Windows 8, где из-за отсутствия привычной кнопки Пуск, именно использование клавиатурных сочетаний является самым удобным способом выполнения многих операций.\n\n1. Win &mdash; вызов меню Пуск (переход в режим Metro в Windows 8);\n\n2. Win+B &mdash; выбрать иконку в системном трее. Затем можно переключаться между разными иконками курсорными клавишами;\n\n3. Win+D &mdash; показать Рабочий стол;\n\n4. Win+E &mdash; открыть Проводник;\n\n5. Win+F &mdash; открыть Поиск;\n\n6. Win+L &mdash; заблокировать компьютер;\n\n7. Win+M &mdash; свернуть все окна;\n\n8. Win+P &mdash; переключение режима работы дополнительного монитора или проектора;\n\n9. Win+R &mdash; открыть диалог Выполнить;\n\n10. Win+T &mdash; активировать Панель задач, при этом выделяется первое приложение на панели. Последующими нажатиями этого сочетания можно перейти к следующим кнопкам, а затем нажатием Enter запустить нужное;\n\n11. Win+U - открыть Центр специальных возможностей;\n\n12. Win+X - Центр мобильных приложений в Windows 7. В Win 8 открывает &laquo;скрытое&raquo; меню Пуск.\n\n13. Win+Pause - открыть свойства системы;\n\n14. Win+F1 &mdash; открыть справку Windows;\n\n15. Win+1,2,3,&hellip; &mdash; аналогично клику на кнопке приложения с соответствующим номером в Панели задач;\n\n16. Win+Shift+1,2,3,&hellip; - аналогично клику средней кнопкой на кнопке приложения с соответствующим номером в Панели задач, то есть запуск новой копии программы;\n\n17. Win+Ctrl+1,2,3,&hellip; &mdash; переключение между разными окнами одной программы;\n\n18. Win+Стрелка вверх &mdash; развернуть окно на весь экран;\n\n19. Win+Стрелка вниз &mdash; восстановить минимизировать окно;\n\n20. Win+Стрелка вправо или влево &mdash; &laquo;прижать&raquo; окно к правой или левой стороне экрана;\n\n21. Win+Shift+Стрелка вправо или влево &mdash; переместить окно на другой монитор;\n\n22. Win+Пробел - взглянуть на рабочий стол в Windows 7 или переключение между раскладками в Windows 8.', '2015-09-08 10:03:09'),
(11, 3, 'Модули памяти Apacer Nox DDR4 SO-DIMM отличаются большим объемом и высокой частотой', 'Оперативная память стандарта DDR4 еще только готовится стать основной для новых стационарных ПК, в ноутбуках ее распространение идет еще неторопливее. Но производители начинают присматриваться к незаполненной рыночной нише: вслед за Kingston HyperX свои модули DDR4 SO-DIMM представила компания Apacer.\n\nМодули Apacer Nox несмотря на свой малый типоразмер обладают большой емкостью в 16 ГБ, так что комплект из четырех таких модулей позволит нарастить объем ОЗУ ноутбука до 64 ГБ. Впрочем ноутбуками сфера применения новинок не ограничивается, многие компактные системные платы тоже оснащаются слотами SO-DIMM.\n\nЧастота модулей Apacer Nox тоже не стала жертвой компактности и составила 3000 МГц, чему могут позавидовать многие &laquo;взрослые&raquo; модули DDR4 DIMM той же Apacer. Напряжение осталось на стандартном уровне 1,2 В, но для лучшего охлаждения производитель решил использовать радиаторы.', '2015-09-08 10:04:38'),
(12, 2, 'refrgerg', 'egergerg', '2015-09-08 13:04:38'),
(13, 2, 'dgdhdth', 'ethrthth', '2015-09-08 13:07:00'),
(14, 2, 'drgfdfgd', 'fgdfgdfh', '2015-09-09 08:47:47'),
(15, 2, 'Улучшенный клон телеприставки Mi Box Mini можно купить дешевле $50', 'Этой весной мы писали о крошечной телеприставке Mi Box Mini, которая подключается прямо в розетку, а с телевизором соединяется традиционным путем через HDMI-кабель.\n\nТеперь же на рынок вышла модель под названием CX-S500, которую можно приобрести дешевле $50. Корпус новинки практически полностью копирует Mi Box Mini, однако данная приставка использует стандартную версию Android 4.4 вместо фирменной прошивки Xiaomi MIUI, которая применена в Mi Box Mini.\nВ аппаратном плане отличий также хватает. CX-S500 использует однокристальную систему Amlogic S805, которая включает четыре процессорных ядра Cortex-A5, работающих на частоте 1,5 ГГц, и GPU Mali-450 MP4. Вышеупомянутая телеприставка использует четыре ядра Cortex-A7, которая работают на частоте 1,3 ГГц, и тот же GPU. В CX-S500 установлено 1 ГБ оперативной (как в Mi Box Mini) и 8 ГБ флэш-памяти, вдвое больше, чем в решении от Xiaomi, а также адаптеры Wi-Fi 802.11b/g/n и Bluetooth.\nПомимо HDMI-порта в CX-S500 также установлен USB-порт, которого нет у Mi Box Mini. Это позволяет подключать клавиатуру, мышь, игровые контроллеры или устройства хранения информации, с которых можно воспроизводить мультимедийный контент.\n\nВ стандартный комплект поставки CX-S500 входят сама приставка, HDMI-кабель и пульт дистанционного управления.', '2015-09-09 12:43:01'),
(16, 7, 'SDFSDFSDF', 'SDFSDFSDFSDF', '2015-09-10 08:49:22'),
(17, 2, 'rfgsdfgdfgd', 'fgdfgdfg', '2015-09-10 09:57:06'),
(18, 2, 'sdfsdfsdf', 'sdfsdf', '2015-09-10 12:24:36'),
(19, 2, 'fvgdfg', 'dfgdfg', '2015-09-11 11:49:21'),
(20, 2, 'sefsef', 'wefwefwef', '2015-09-11 12:00:41'),
(21, 2, 'sdfsdf', 'sdfsdf', '2015-09-11 12:00:53'),
(22, 2, 'zsdcsdv', 'sdvsdvsd', '2015-09-11 12:06:44');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(30) NOT NULL,
  `pass` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `pass`) VALUES
(1, 'admin', '2e99bf4e42962410038bc6fa4ce40d97'),
(2, 'Arslanbek', '2e99bf4e42962410038bc6fa4ce40d97'),
(3, 'soft2', '2e99bf4e42962410038bc6fa4ce40d97'),
(4, 'Arslanbek1', '2e99bf4e42962410038bc6fa4ce40d97'),
(5, 'sila', '5c16a6699b13cb153dda5adda247c216'),
(6, 'sila2', '2e99bf4e42962410038bc6fa4ce40d97'),
(7, 'arslanbek3', '2e99bf4e42962410038bc6fa4ce40d97');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;