
#Область СлужебныйПрограммныйИнтерфейс

Функция Сутки() Экспорт
	Возврат 60*60*24;
КонецФункции

Функция СтатусЗаказаКаргомарт(СтатусВходящий) Экспорт
	
	СоответствиеСтатусов = Новый Соответствие;
	СоответствиеСтатусов.Вставить(1, "Черновик");
	СоответствиеСтатусов.Вставить(2, "Черновик");
	СоответствиеСтатусов.Вставить(3, "Опубликован");
	СоответствиеСтатусов.Вставить(4, "ВТоргах");
	СоответствиеСтатусов.Вставить(5, "ОбработкаПослеТоргов");
	СоответствиеСтатусов.Вставить(6, "Исполняется");
	СоответствиеСтатусов.Вставить(7, "Завершен");
	СоответствиеСтатусов.Вставить(8, "Архивный");
	СоответствиеСтатусов.Вставить(9, "Удален");
	
	Возврат СоответствиеСтатусов[СтатусВходящий];
	
КонецФункции

Функция ТипыГрузовиков() Экспорт
	
	Результат = Новый Соответствие;
	Результат.Вставить(1, "Трал");
	Результат.Вставить(2, "Цист. пищевая");
	Результат.Вставить(3, "Цист. ГСМ");
	Результат.Вставить(4, "Рефрижератор");
	Результат.Вставить(5, "Тент");
	Результат.Вставить(6, "Бортовой");
	Результат.Вставить(7, "Промтовар");
	Результат.Вставить(8, "Зерновоз");
	Результат.Вставить(9, "Муковоз");
	Результат.Вставить(10, "Изотерм");
	Результат.Вставить(11, "Тягач");
	Результат.Вставить(12, "Тушевоз");
	Результат.Вставить(13, "Цельномет");
	Результат.Вставить(14, "Скотовоз");
	Результат.Вставить(15, "Лесовоз");
	Результат.Вставить(16, "Без бортов");
	Результат.Вставить(17, "Самосвал");
	Результат.Вставить(18, "Автовоз");
	Результат.Вставить(19, "Цементовоз");
	Результат.Вставить(20, "Контейнеровоз");
	Результат.Вставить(21, "Ломовоз");
	Результат.Вставить(22, "Контейнер");
	Результат.Вставить(23, "Двухкам. реф.");
	
	Возврат Результат;
	
КонецФункции

Функция ТипыПогрузкиРазгрузки() Экспорт
	
	Результат = Новый Соответствие;
	Результат.Вставить(1, "Верхняя загрузка");
	Результат.Вставить(2, "Задняя загрузка");
	Результат.Вставить(3, "Боковая загрузка");
	Результат.Вставить(4, "Полная растентовка");
	
	Возврат Результат;
	
КонецФункции

Функция ЗаполнитьПредставлениеТипыПогрузки(ТипыПогрузкиЗначения) Экспорт
	
	ТипыПогрузкиРазгрузки 	= ТипыПогрузкиРазгрузки();
	Результат 				= "";
	
	Для Каждого ТипПогрузкиРазгрузки из ТипыПогрузкиРазгрузки Цикл
		Если СтрНайти(ТипыПогрузкиЗначения, Строка(ТипПогрузкиРазгрузки.Ключ))<> 0 Тогда
			Результат = Результат + ?(Результат = "", "", ", ")
				+ ТипПогрузкиРазгрузки.Значение;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ЗначениеВJSON(Данные) Экспорт
	
	Результат = Неопределено;

#Если ВебКлиент Тогда
	Возврат Результат;		  
#Иначе
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ПараметрыJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, " ");
	ЗаписьJSON.УстановитьСтроку(ПараметрыJSON);
	ЗаписатьJSON(ЗаписьJSON, Данные);

	Возврат ЗаписьJSON.Закрыть();	

#КонецЕсли
	
КонецФункции

Функция ЗначениеИзJSON(СтрокаJSON) Экспорт
	
	Результат = Неопределено;
	
#Если ВебКлиент Тогда
	Возврат Результат;
#Иначе
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(СтрокаJSON);
	
	Попытка
		Результат = ПрочитатьJSON(ЧтениеJSON, Ложь);
	Исключение
		Результат = Неопределено;
	КонецПопытки;

	Возврат Результат; 
		
#КонецЕсли
	
		
КонецФункции

// Инициализировать структуру возврата.
// 
// Возвращаемое значение:
//  Структура - Инициализировать структуру возврата:
// * КодОшибки - Число -
// * Лог - Строка -
// * Описание - Строка -
Функция ИнициализироватьСтруктуруВозврата() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("КодОшибки", 0);
	Результат.Вставить("Лог", 		"");
	Результат.Вставить("Описание", 	"");
	Возврат Результат;
	
КонецФункции

//Возвращаемое значение:
//	Строка - Текст готового сообщения.
//@skip-check method-too-many-params
Функция СообщениеПользователю(КодСообщения, П1 = Неопределено, П2 = Неопределено, П3 = Неопределено, П4 = Неопределено, П5 = Неопределено, П6 = Неопределено, 
											 П7 = Неопределено, П8 = Неопределено, П9 = Неопределено) Экспорт
	Сообщения = Новый Соответствие;
	
	Сообщения.Вставить(1, "Для организации ""%1"" не заполнены настройки связи с Каргомарт");
	Сообщения.Вставить(2, "Ошибка при обращении к HTTP-сервису Каргомарт:
		|─────────────────────────────────────────────────────────────────────────
		|	Cервер:	%1
		|	Путь:	%2
		|	Порт:	%3
		|	Логин:	%4
		|	Пароль: *******
		|─────────────────────────────────────────────────────────────────────────
		|Подробное представление ошибки:
		|	%5
		|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(3, "Ошибка при обращении к HTTP-сервису Каргомарт:
		|─────────────────────────────────────────────────────────────────────────
		|	Cервер:	%1
		|	Путь:	%2
		|	Порт:	%3
		|	Токен:	%4
		|─────────────────────────────────────────────────────────────────────────
		|Подробное представление ошибки:
		|	%5
		|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(4, "Ошибка при получении ответа от Каргомарт:
		|─────────────────────────────────────────────────────────────────────────
		|	Cервер:		%1
		|	Путь:		%2
		|	Порт:		%3
		|	Токен:		%4
		|─────────────────────────────────────────────────────────────────────────
		|Полученные данные не прошли проверку формата:
		|%5
		|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(5, "Не удалось записать заказ №%1 в БД. Подробно:
		|%2");
	Сообщения.Вставить(6, "Ошибка разбора JSON-тела сообщения. Полученное сообщение: 
			|%1");
	Сообщения.Вставить(7, "Заказ №%1: Не удалось определить договор с %2. Загрузка прервана.");
	Сообщения.Вставить(8, "Не найден заказ Каргомарт №%1");
	Сообщения.Вставить(9, "По заказу Каргомарт №%1 указанный статус уже установлен (%2)");
	Сообщения.Вставить(10,"Не найдены документы ПТУ и РТУ для заказа Каргомарт №%1");
	Сообщения.Вставить(11,"Не найден документ %2 для заказа Каргомарт №%1");
	Сообщения.Вставить(12,"Ошибка %2 документов для заказа Каргомарт №%1
		|Подробности: %3");
	Сообщения.Вставить(13,"Заказ Каргомарт №%1 заблокирован пользователем ""%2""! ");
	Сообщения.Вставить(14, "Ошибка записи в БД.");
	Сообщения.Вставить(15, "Не удалось записать документ ""ЗаявкаНаРасходованиеДенежныхСредств"".");
	Сообщения.Вставить(16, "Ошибка при отправке результата проверки %2 по заказу Каргомарт:
			|─────────────────────────────────────────────────────────────────────────
			|	Заказ Каргомарт: 	%1
			|─────────────────────────────────────────────────────────────────────────
			|Подробное представление ошибки:
			|	Не найден заказ Каргомарт с указанным идентификатором для указанной организации.
			|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(17, "Ошибка при отправке результата проверки %2 по заказу Каргомарт:
			|─────────────────────────────────────────────────────────────────────────
			|	Заказ Каргомарт: 	%1
			|─────────────────────────────────────────────────────────────────────────
			|Подробное представление ошибки:
			|	Не найден параметр ""%3"" в детальной информации заказа Каргомарт.
			|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(18, "Ошибка при записи в БД документов к заказу Каргомарт:
			|─────────────────────────────────────────────────────────────────────────
			|	Номер заказа:	%1
			|	ИД документа:	%2
			|─────────────────────────────────────────────────────────────────────────
			|Подробное представление ошибки:
			|	%3
			|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(19, "Тип значения не соответствует формату.");
	Сообщения.Вставить(20, "Не найдено поле ""%1"", требуемое по формату.");
	Сообщения.Вставить(21, "Не заполнен параметр ""%1""");
	Сообщения.Вставить(22, "Ошибка при записи в регистр ""КДВКаргомартЗаказы"":
			|─────────────────────────────────────────────────────────────────────────
			|    Идентификатор:		%1 
			|    Организация:		%2
			|    Дата Погрузки:		%3
			|    Дата Выгрузки:		%4
			|    Заказчик:			%5
			|    Перевозчик:		%6
			|─────────────────────────────────────────────────────────────────────────
			|Подробное представление ошибки:
			|    %7
			|─────────────────────────────────────────────────────────────────────────");
	Сообщения.Вставить(23, "Документ РТУ не проведён. Отправка через сервис ЭДО невозможна.");
	Сообщения.Вставить(24, "Не могу получить ИД организации на сервере Диадок.");
	Сообщения.Вставить(25, "Не могу получить ИД контрагента на сервере Диадок.");
	Сообщения.Вставить(26, "Документ уже отправлен через сервис ЭДО Диадок.");
	Сообщения.Вставить(27, "Для документа РТУ не создана Счет-фактура. Отправка через сервис ЭДО отменена.");
	Сообщения.Вставить(28, "Ошибка: Не найдено исполнителя для данного типа задач.
			|Пропускаю.");
	Сообщения.Вставить(29, "Не найден объект в БД");
	Сообщения.Вставить(30, "Значение поля объекта ""%1"" не совпадает.");
	Сообщения.Вставить(31, "Количество строк в таб. части объекта ""%1"" не совпадает.");
	Сообщения.Вставить(32, "В %1 отсутствует поле ""%2"".");
	Сообщения.Вставить(33, "Не найден узел обмена Каргомарт ""%1""");
	Сообщения.Вставить(34, "Не найдены данные о платежах, зарегистрированные к передаче для узла обмена Каргомарт ""%1""");
	Сообщения.Вставить(35, "Ошибка получения данных заказа Каргомарт в БД по указанному документу.");
	Сообщения.Вставить(36, "Заявка на перечсление ДС ещё не исполнена. Выгрузка в Каргомарт не требуется.");
	Сообщения.Вставить(37, "Протокол обмена с Каргомарт версии 1 не поддерживает данную функцию.");
	Сообщения.Вставить(38, "Не удалось расчитать дату платежа. Заполните производственный календарь на текущий и, возможно, следующий год.");
	Сообщения.Вставить(39, "");
	Сообщения.Вставить(40, "В выбранных заказах Каргомарт не совпадают %1.");
	Сообщения.Вставить(41, "Заказ Каргомарт №%1 объединен с заказами, не входящими в выбранную для объединения группу заказов.");
	Сообщения.Вставить(42, "Удалена строка в ""%1"", соответствующая заказу Каргомарт №%2");
	Сообщения.Вставить(43, "Внимание! в ""%1"" по заказу Каргомарт №%2 количество строк таб. части ""Услуги"" не совпадает с количеством заказов, ссылающихся на документ!");
	Сообщения.Вставить(44, "Не найдена строка в ""%1"", соответствующая заказу Каргомарт №%2!");
	Сообщения.Вставить(45, "Заявка на оплату перевозчику уже исполнена, и не может быть отменена.");
	Сообщения.Вставить(46, "Отсутствуют права доступа на установку пометки удаления для заявок на расходование денежных средств. Заявка на оплату перевозчику нне может быть отменена.");
	
	Результат 	= Сообщения.Получить(КодСообщения);
	
	Параметр 	= Неопределено;
	
	Для Итр = 1 По 9 Цикл

#Если Не ВебКлиент Тогда
	//@skip-check server-execution-safe-mode
	Выполнить("Параметр = П" + Итр + ";");
#КонецЕсли
		
		Если Параметр = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Результат = СтрЗаменить(Результат, "%" + Итр, Строка(Параметр));
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Функция ИмпортироватьДату(ДатаСтрокой) Экспорт
	
	МассивВремени = СтрРазделить( ДатаСтрокой, "+" );
	
	Дата = Дата(СтрЗаменить( СтрЗаменить( СтрЗаменить( МассивВремени[ 0 ], "-", "" ), " ", "" ), ":", "" ));
	Если МассивВремени.Количество() > 1 Тогда 
		ДобавочныеЧасы = МассивВремени[ 1 ];
		ДобавочныеЧасы = Число( Лев( ДобавочныеЧасы, 2 ) ) * 3600 + ?( СтрДлина( ДобавочныеЧасы ) > 2, Число( Сред( ДобавочныеЧасы, 3 ) ) * 60, 0 );
		Дата = Дата + ДобавочныеЧасы;		
	КонецЕсли;
	
	Возврат Дата;
	
КонецФункции

Функция ЭтоЧисло(Знач ПроверяемоеЗначение) Экспорт
	
	Если Строка(ПроверяемоеЗначение) = "0" Тогда
		Возврат Истина;
	КонецЕсли;
	
	ОписаниеЧисла = Новый ОписаниеТипов("Число");
	Возврат ОписаниеЧисла.ПривестиЗначение(ПроверяемоеЗначение) <> 0;
	
КонецФункции

Функция ПолучитьДополнительныеСведенияИзДетальнойИнформации_v1(ДетальнаяИнформация) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("ГрузоОтправитель", 			"");
	Результат.Вставить("ГрузоПолучатель", 			"");
	Результат.Вставить("ВариантОплатыПеревозки", 	"ОплатаПоОригиналам");
	Результат.Вставить("ОписаниеГруза", 			0);
	Результат.Вставить("ТипМашины", 				"");
	Результат.Вставить("Машина", 					"");
	Результат.Вставить("Водитель", 					"");
	Результат.Вставить("КомментарийЗаказчика", 		"");
	Результат.Вставить("ПочтоваяСлужба", 			"");
	
	Если ДетальнаяИнформация.order.point[0].Свойство("legalName") Тогда
		Результат.ГрузоОтправитель = ДетальнаяИнформация.order.point[0].legalName;
	КонецЕсли;
	
	ИндПоследнейТочки 			= ДетальнаяИнформация.order.point.Количество()-1;
	Результат.ОписаниеГруза 	= ДетальнаяИнформация.order.cargoType;
	
	Если ДетальнаяИнформация.order.point[ИндПоследнейТочки].Свойство("legalName") Тогда
		Результат.ГрузоПолучатель = ДетальнаяИнформация.order.point[ИндПоследнейТочки].legalName;
	КонецЕсли;
	
	Для Каждого ЭлтТипМашины из ДетальнаяИнформация.truckType Цикл
		Если ЭлтТипМашины.id = ДетальнаяИнформация.order.truckTypeId Тогда
			
			Результат.ТипМашины = ЭлтТипМашины.name + ", ";
			Прервать;
			
		КонецЕсли;
	КонецЦикла;
	
	Если ДетальнаяИнформация.order.Свойство("truck") Тогда
		
		СтрМашина 			= ДетальнаяИнформация.order.truck;
		Результат.Машина 	= "" + ?(СтрМашина.Свойство("carryingCapacity"), Строка(СтрМашина.carryingCapacity) + "т, ", "") 
			+ Результат.ТипМашины + ?(СтрМашина.Свойство("manufacturer"), СтрМашина.manufacturer + " ", "") 
			+ ?(СтрМашина.Свойство("number"), СтрМашина.number, "") + ", " 
			+ ?(СтрМашина.Свойство("manufacturerTrailer"), СтрМашина.manufacturerTrailer, "") + " " 
			+ ?(СтрМашина.Свойство("numberTrailer"), СтрМашина.numberTrailer, "");
		
	КонецЕсли;
	
	Если ДетальнаяИнформация.order.Свойство("driver") Тогда
		
		СтрВодитель = ДетальнаяИнформация.order.driver;
		
		ТелВодителя = "";	
		
		Для Каждого ТелефонВодителя из СтрВодитель.phones Цикл
			ТелВодителя = ТелВодителя + ?(ТелВодителя = "", "", ", ") + ТелефонВодителя;
		КонецЦикла;
		
		ТелВодителя = ?(ТелВодителя = "", "", ", тел.: ") + ТелВодителя;
		
		Результат.Водитель 	= ?(СтрВодитель.Свойство("name"), СтрВодитель.name, "") + ?(СтрВодитель.Свойство("birthDate"), ", дата рождения " + СтрВодитель.birthDate, "") 
			+ ", паспорт " + ?(СтрВодитель.Свойство("passportSeries"), СтрВодитель.passportSeries, "") + " " + ?(СтрВодитель.Свойство("passportNumber"), СтрВодитель.passportNumber, "") 
			+ " выдан " + ?(СтрВодитель.Свойство("passportBy"), СтрВодитель.passportBy, "") 
			+ ", дата выдачи: " + ?(СтрВодитель.Свойство("passportWhen"), СтрВодитель.passportWhen, "")
			+ ТелВодителя;
		
	КонецЕсли;
	
	Для Каждого Деталь Из ДетальнаяИнформация.order.details Цикл
		Если Деталь.type = "COMMON" Тогда
			Результат.КомментарийЗаказчика = Результат.КомментарийЗаказчика + ?(Результат.КомментарийЗаказчика = "", "", Символы.ПС) + Деталь.content;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьДополнительныеСведенияИзДетальнойИнформации_v2(ДетальнаяИнформация) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("ГрузоОтправитель", 			"");
	Результат.Вставить("ГрузоПолучатель", 			"");
	Результат.Вставить("ОписаниеГруза", 			"");
	Результат.Вставить("ТипМашины", 				"");
	Результат.Вставить("Машина", 					"");
	Результат.Вставить("Водитель", 					"");
	Результат.Вставить("КомментарийЗаказчика", 		"");
	Результат.Вставить("ПочтоваяСлужба", 			"");
	
	Если ДетальнаяИнформация.proposal.route[0].Свойство("cargoOwner") Тогда 
		Если ДетальнаяИнформация.proposal.route[0].cargoOwner.Свойство("shortName") Тогда
			Результат.ГрузоОтправитель = ДетальнаяИнформация.proposal.route[0].cargoOwner.shortName;
		ИначеЕсли ДетальнаяИнформация.proposal.route[0].cargoOwner.Свойство("legalName") Тогда
			Результат.ГрузоОтправитель = ДетальнаяИнформация.proposal.route[0].cargoOwner.legalName;
		КонецЕсли;
	ИначеЕсли ДетальнаяИнформация.proposal.route[0].Свойство("storage")
		И ДетальнаяИнформация.proposal.route[0].storage.Свойство("title") Тогда
			Результат.ГрузоОтправитель = ДетальнаяИнформация.proposal.route[0].storage.title;
	КонецЕсли;
	
	ИндПоследнейТочки = ДетальнаяИнформация.proposal.route.Количество()-1;
	
	Если ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].Свойство("cargoOwner") Тогда
		Если ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].cargoOwner.Свойство("shortName") Тогда
			Результат.ГрузоПолучатель = ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].cargoOwner.shortName;
		ИначеЕсли ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].cargoOwner.Свойство("legalName") Тогда
			Результат.ГрузоПолучатель = ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].cargoOwner.legalName;
		КонецЕсли;
	ИначеЕсли ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].Свойство("storage")
		И ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].storage.Свойство("title") Тогда
			Результат.ГрузоПолучатель = ДетальнаяИнформация.proposal.route[ИндПоследнейТочки].storage.title;
	КонецЕсли;
	
	Результат.ОписаниеГруза 			= ДетальнаяИнформация.proposal.cargo.description;
	
	Если ДетальнаяИнформация.proposal.carrier.Свойство("originalDocument") Тогда
		Результат.ПочтоваяСлужба = ДетальнаяИнформация.proposal.carrier.originalDocument.postServiceName;
	КонецЕсли;
	
	Если ДетальнаяИнформация.proposal.carrier.Свойство("truck") Тогда
		
		СтрМашина 	= ДетальнаяИнформация.proposal.carrier.truck;
		Результат.ТипМашины 	= ?(СтрМашина.Свойство("truckTypeName"), стрМашина.truckTypeName, Результат.ТипМашины);
		Результат.Машина 		= "" + ?(СтрМашина.Свойство("carryingCapacity"), Строка(СтрМашина.carryingCapacity) + "т, ", "") 
			+ Результат.ТипМашины 
			+ ?(СтрМашина.Свойство("manufacturer"), СтрМашина.manufacturer + " ", "") 
			+ ?(СтрМашина.Свойство("number"), СтрМашина.number, "") + ", " 
			+ ?(СтрМашина.Свойство("manufacturerTrailer"), СтрМашина.manufacturerTrailer, "") + " " 
			+ ?(СтрМашина.Свойство("numberTrailer"), СтрМашина.numberTrailer, "");
		
	КонецЕсли;
	
	Если ДетальнаяИнформация.proposal.carrier.Свойство("driver") Тогда
		
		СтрВодитель = ДетальнаяИнформация.proposal.carrier.driver;
		
		ТелВодителя = "";	
		
		Для Каждого ТелефонВодителя из СтрВодитель.phones Цикл
			ТелВодителя = ТелВодителя + ?(ТелВодителя = "", "", ", ") + ТелефонВодителя;
		КонецЦикла;
		
		ТелВодителя = ?(ТелВодителя = "", "", ", тел.: ") + ТелВодителя;
		Результат.Водитель 	= ?(СтрВодитель.Свойство("name"), СтрВодитель.name, "")
			+ ?(СтрВодитель.Свойство("birthDate"), ", дата рождения " + СтрВодитель.birthDate, "") 
			+ ", паспорт " + ?(СтрВодитель.Свойство("passportSeries") + " ", СтрВодитель.passportSeries, "") + ?(СтрВодитель.Свойство("passportNumber"), СтрВодитель.passportNumber + " ", "") 
			+ "выдан " + ?(СтрВодитель.Свойство("passportBy"), СтрВодитель.passportBy, "") 
			+ ", дата выдачи: " + ?(СтрВодитель.Свойство("passportWhen"), СтрВодитель.passportWhen + " ", "")
			+ ТелВодителя;
		
	КонецЕсли;
	
	Если ДетальнаяИнформация.proposal.Свойство("comment") Тогда
		Результат.КомментарийЗаказчика = ДетальнаяИнформация.proposal.comment;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ИмяДСДетальнаяИнформация() Экспорт
	//Функция возвращает имя свойства РС "КДВКаргомартДлинныеСтроки", в котором хранится детальная информация по заказу в JSON-строке.
	Возврат "ДетальнаяИнформация";
КонецФункции

Функция ИмяДСКомментарийЗаказчика() Экспорт
	//Функция возвращает имя свойства РС "КДВКаргомартДлинныеСтроки", в котором хранится комментарий заказчика к заказу.
	//Обычно, там хранятся дополнительные требования к оформлению документов, правилам и особенностям получения груза и пр.
	Возврат "КомментарийЗаказчика";
КонецФункции

Функция ПунктВФорматКаргомарт(Данные) Экспорт

	Результат = Новый Структура;
	
	Для каждого Элемент из Данные Цикл
		
		Если Элемент.Ключ = "ИД" 							Тогда
			Результат.Вставить("id", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "Наименование" 			Тогда
			Результат.Вставить("title", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "НаселенныйПункт" 			Тогда
			Результат.Вставить("localityName", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "КЛАДР"					Тогда
			Результат.Вставить("code", СтрЗаменить("001" + Строка(Элемент.Значение), Символы.НПП, ""));
		ИначеЕсли Элемент.Ключ = "Адрес"					Тогда
			Результат.Вставить("address", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "НомерДома" 				Тогда
			Результат.Вставить("house", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "Комментарий" 				Тогда
			Результат.Вставить("comment", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "КоординатыШирота" и Элемент.Значение > 0		Тогда
			Результат.Вставить("latitude", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "КоординатыДолгота" и Элемент.Значение > 0		Тогда
			Результат.Вставить("longitude", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "ФормаОрганизации" и Элемент.Значение > 0		Тогда
			Результат.Вставить("legalStatus", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "Контрагент" 				Тогда
			Результат.Вставить("pointShipper", Элемент.Значение);
		ИначеЕсли Элемент.Ключ = "ЮридическоеНаименование" 	Тогда
			Результат.Вставить("legalName", Элемент.Значение);
		КонецЕсли;	
			
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ПроверитьСтроку(Строка, Фасет) Экспорт

#Если ВебКлиент Тогда
	Возврат Истина;
#КонецЕсли
	
#Если НЕ ВебКлиент Тогда
	
    Чтение = Новый ЧтениеXML;
    Чтение.УстановитьСтроку(
                "<Model xmlns=""http://v8.1c.ru/8.1/xdto"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xsi:type=""Model"">
                |<package targetNamespace=""sample-my-package"">
                |<valueType name=""testtypes"" base=""xs:string"">
                |<pattern>" + Фасет + "</pattern>
                |</valueType>
                |<objectType name=""TestObj"">
                |<property xmlns:d4p1=""sample-my-package"" name=""TestItem"" type=""d4p1:testtypes""/>
                |</objectType>
                |</package>
                |</Model>");

    Модель = ФабрикаXDTO.ПрочитатьXML(Чтение);
    МояФабрикаXDTO = Новый ФабрикаXDTO(Модель);
    Пакет = МояФабрикаXDTO.Пакеты.Получить("sample-my-package");
    Тест = МояФабрикаXDTO.Создать(Пакет.Получить("TestObj"));

    Попытка
        Тест.TestItem = Строка;
        Возврат Истина
    Исключение
        Возврат Ложь
    КонецПопытки;
    
#КонецЕсли
 
КонецФункции

#КонецОбласти
