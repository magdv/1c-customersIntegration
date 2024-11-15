
&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	Если НЕ ЗначениеЗаполнено(Организация) Тогда
		Возврат;
	КонецЕсли;
	
	ОП = Новый ОписаниеОповещения("ВопросОрганизацияПриИзмененииЗавершение", ЭтаФорма, Неопределено);
	ПоказатьВопрос(ОП, "Перечитать настройки, сохранённые для выбранной организации?",РежимДиалогаВопрос.ДаНет, 10, КодВозвратаДиалога.Нет,, КодВозвратаДиалога.Нет);
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросОрганизацияПриИзмененииЗавершение(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		
		ПрочитатьНастройкиКаргомартНаСервере(Организация);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНастройкиКаргомартНаСервере(Организация)
	
	Результат = КМ_ОбщийМодульВызовСервера.ПолучитьНастройкиКаргоМарт(Организация);
	
	Если НЕ ЗначениеЗаполнено(Результат) Тогда
		
		Сообщить("Не найдено сохранённых настроек.");
		Возврат;
		
	КонецЕсли;
	
	РезультатВСтаромФормате = ПреобразоватьИзНовогоВСтарыйФормат(Результат);
	ЗаполнитьНастройкиИзСтруктуры(РезультатВСтаромФормате);
	
	НомерПоследнегоЗапросаКаргомарт = КМ_ОбщийМодульСервер.ПолучитьНомерПоследнегоЗапросаКаргомарт(Организация, "Протокол_v" + ВерсияПротокола);
	
	Попытка
		ПереключательПротокола = Число(Лев(РезультатВСтаромФормате.ВерсияПротокола, 1));
	Исключение
		
		ПереключательПротокола 	= 2;
		ВерсияПротокола 		= "2";
		Сообщить("Ошибка определения версии протокола в сохраненных настройках.");
		
	КонецПопытки
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНастройкиКаргомартНаСервере()
	
	СтруктураНастройки 	= Новый Структура;
	Записи 				= Новый Массив;
	
	ТекущиеНастройки = ОсновныеНастройкиВСтруктуру();
	
	МЗап = РегистрыСведений.ДополнительныеСведения.СоздатьМенеджерЗаписи();
	МЗап.Объект 	= Организация;
	МЗап.Свойство 	= КМ_ОбщийМодульПовтИсп.РеквизитНомерПоследнегоЗапросаКаргомарт("Протокол_v" + ТекущиеНастройки.ВерсияПротокола);
	МЗап.Значение 	= НомерПоследнегоЗапросаКаргомарт;
	Записи.Добавить(МЗап);
	
	СтруктураНастройки.Вставить("Протокол_v" + ТекущиеНастройки.ВерсияПротокола, ТекущиеНастройки);
	ТекущиеНастройки.Удалить("ВерсияПротокола");
	
	АльтернативныеНастройки = ЗначениеИзСтрокиВнутр(НастройкиАльтернативногоПротокола);
	
	МЗап = РегистрыСведений.ДополнительныеСведения.СоздатьМенеджерЗаписи();
	МЗап.Объект 	= Организация;
	МЗап.Свойство 	= КМ_ОбщийМодульПовтИсп.РеквизитНомерПоследнегоЗапросаКаргомарт("Протокол_v" + АльтернативныеНастройки.ВерсияПротокола);
	МЗап.Значение 	= АльтернативныеНастройки.НомерПоследнегоЗапросаКаргомарт;
	Записи.Добавить(МЗап);
	
	СтруктураНастройки.Вставить("Протокол_v" + АльтернативныеНастройки.ВерсияПротокола, АльтернативныеНастройки);
	АльтернативныеНастройки.Удалить("ВерсияПротокола");
	
	Результат = КМ_ОбщийМодульВызовСервера.СохранитьНастройкиКаргоМарт(Организация, СтруктураНастройки);
	
	Если Результат <> Истина Тогда
		Сообщить("Не удалось записать настройки в БД!");
		Возврат;
	КонецЕсли;
	
	
	
	Попытка
		
		НачатьТранзакцию();
		
		Для Каждого МЗап из Записи ЦИкл
			МЗап.Записать(Истина);
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		Сообщить("Не удалось записать  параметры ""НомерПоследнегоЗапросаКаргомарт"".");
		
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьНастройкиКаргомарт(Команда)
	ЗаписатьНастройкиКаргомартНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательПротоколаПриИзменении(Элемент)
	
	НовыеНастройкиАльтПротокола = ОсновныеНастройкиВСтроку();
	
	ОсновныеНастройкиИзСтроки(НастройкиАльтернативногоПротокола);
	
	НастройкиАльтернативногоПротокола = НовыеНастройкиАльтПротокола;
	
	Если Лев(ВерсияПротокола, 1) <> Формат(ПереключательПротокола,"ЧГ=") Тогда
		ВерсияПротокола = Формат(ПереключательПротокола,"ЧГ=");
	КонецЕсли;
	
	
КонецПроцедуры

&НаСервере
Функция ОсновныеНастройкиВСтроку()
	
	Возврат ЗначениеВСтрокуВнутр(ОсновныеНастройкиВСтруктуру());
	
КонецФункции

&НаСервере
Процедура ОсновныеНастройкиИзСтроки(СтрокаНастроек)
	
	Попытка
		ОсновныеНастройки = ЗначениеИзСтрокиВнутр(СтрокаНастроек);
	Исключение
		ОсновныеНастройки = Неопределено;
	КонецПопытки;
	
	Если ТипЗнч(ОсновныеНастройки) <> Тип("Структура") Тогда
		
		Сообщить("Ошибка восстановления настроек из строки.");
		Возврат;
		
	КонецЕсли;
	
	ЗаполнитьНастройкиИзСтруктуры(ОсновныеНастройки);
	
	Если ОсновныеНастройки.Свойство("НомерПоследнегоЗапросаКаргомарт") = Ложь Тогда
		НомерПоследнегоЗапросаКаргомарт = 0;
	КонецЕсли;
	
	НомерПоследнегоЗапросаКаргомарт = КМ_ОбщийМодульСервер.ПолучитьНомерПоследнегоЗапросаКаргомарт(Организация, "Протокол_v" + ВерсияПротокола);
	
КонецПроцедуры


&НаСервере
Функция ОсновныеНастройкиВСтруктуру()
	
	СтруктураНастройки = Новый Структура;
	СтруктураНастройки.Вставить("АдресСервера", 			АдресСервера);
	СтруктураНастройки.Вставить("Логин", 					Логин);
	СтруктураНастройки.Вставить("Пароль", 					Пароль);
	СтруктураНастройки.Вставить("ПодразделениеЗатрат", 		ПодразделениеЗатрат);
	СтруктураНастройки.Вставить("СчетДоходовРТУ", 			СчетДоходовРТУ);
	СтруктураНастройки.Вставить("СчетРасходовРТУ", 			СчетРасходовРТУ);
	СтруктураНастройки.Вставить("СчетУчетаНДС", 			СчетУчетаНДС);
	СтруктураНастройки.Вставить("СчетУчетаНДСПоРеализации", СчетУчетаНДСПоРеализации);
	СтруктураНастройки.Вставить("СчетЗатрат", 				СчетЗатрат);
	СтруктураНастройки.Вставить("Субконто1_НГ", 			Субконто1_НГ);
	СтруктураНастройки.Вставить("Субконто2_СЗ", 			Субконто2_СЗ);
	СтруктураНастройки.Вставить("ВерсияПротокола", 			ВерсияПротокола);
	СтруктураНастройки.Вставить("НомерПоследнегоЗапросаКаргомарт",
															НомерПоследнегоЗапросаКаргомарт);
	СтруктураНастройки.Вставить("СтатьяДДСОплатаТранспортныхУслуг", 			
															СтатьяДДСОплатаТранспортныхУслуг);
	СтруктураНастройки.Вставить("ПодразделениеОрганизации", ПодразделениеОрганизации);
	СтруктураНастройки.Вставить("СпособУчетаНДС", 			СпособУчетаНДС);
	
	Возврат СтруктураНастройки;
	
КонецФункции

&НаСервере
Функция ПреобразоватьИзНовогоВСтарыйФормат(СтруктураНастройкиВх)
	
	СтруктураНастройки = ЗначениеИзСтрокиВнутр(ЗначениеВСтрокуВнутр(СтруктураНастройкиВх));
	
	Результат = Новый Структура;
	
	Если СтруктураНастройки.Свойство("Протокол_v2") Тогда
		
		Результат = СтруктураНастройки.Протокол_v2;
		Результат.Вставить("ВерсияПротокола", "2");
		
		Если СтруктураНастройки.Свойство("Протокол_v1") Тогда
			
			СтруктураНастройки.Протокол_v1.Вставить("ВерсияПротокола", "1");
			Результат.Вставить("НастройкиАльтернативногоПротокола", ЗначениеВСтрокуВнутр(СтруктураНастройки.Протокол_v1));
			
		КонецЕсли;
		
	ИначеЕсли СтруктураНастройки.Свойство("Протокол_v1") Тогда
		
		Результат = СтруктураНастройки.Протокол_v1;
		Результат.Вставить("ВерсияПротокола", "1");
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьНастройкиИзСтруктуры(СтруктураНастройки)
	
	Для Каждого Настройка из СтруктураНастройки Цикл
		Попытка
			ЭтаФорма[Настройка.Ключ] = Настройка.Значение;
		Исключение
			Сообщить("В настройках наден неизвестный параметр """ + Настройка.Ключ + """!");
		КонецПопытки;
	КонецЦикла;
		
КонецПроцедуры
