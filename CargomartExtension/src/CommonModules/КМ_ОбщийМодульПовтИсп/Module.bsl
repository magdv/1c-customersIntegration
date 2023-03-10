#Область СлужебныйПрограммныйИнтерфейс

//Возврат/создание дополнительной обработки из макета в зависимости от конфы
// 
// Возвращаемое значение:
//  Структура - Структура подключеной дополнителной обработкой
Функция МодульЯдро() Экспорт
	
	ИмяКонфигурации = Метаданные.Имя;
	
	Результат = "Нет модуля для конфигурации " + ИмяКонфигурации;
	
	Если ИмяКонфигурации = "БухгалтерияПредприятия" Тогда		
		Результат = КМ_ОбщийМодульСервер.ПодключитьОбработкуБП("КМ_ОбщийМодуль_БП_epf");				
	Иначе
		Результат = КМ_ОбщийМодульСервер.ПодключитьОбработкуБП("КМ_ОбщийМодуль_УТ_epf");	
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

//Возврат/создание дополнительного свойства "КМ_РабочееМесто"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит настройки Каргомарт
Функция РеквизитНастройкиКаргомарт() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Организации"));
	
	НаименованиеРеквизита 	= "Настройки Каргомарт";
	ИмяРеквизита 			= "НастройкиКаргомарт";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("СправочникСсылка.ЗначенияСвойствОбъектов"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов);
	//Если не хватит этой длины (1024 символа), то придется делать тип "ЗначенияСвойствОбъектов", 
	//и там в поле "ПолноеНаименование" хранить всю строку неогр. длины.
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

//Возврат/создание дополнительного свойства "НомерПоследнегоЗапросаКаргомарт"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит номер последнего запроса Каргомарт
Функция РеквизитНомерПоследнегоЗапросаКаргомарт() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Организации"));
	
	НаименованиеРеквизита 	= "Номер последнего запроса Каргомарт";
	ИмяРеквизита 			= "НомерПоследнегоЗапросаКаргомарт";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Число"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,,Новый КвалификаторыЧисла(7,0,ДопустимыйЗнак.Неотрицательный));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

//Возврат/создание дополнительного свойства "ЯщикРассылкиСистемныхСообщений"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит ящик рассылки системных сообщений
Функция РеквизитЯщикРассылкиСистемныхСообщений() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Физические лица", Истина));
	
	НаименованиеРеквизита 	= "Ящик рассылки системных сообщений";
	ИмяРеквизита 			= "ЯщикРассылкиСистемныхСообщений";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Строка"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,Новый КвалификаторыСтроки(50));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);

КонецФункции

//Возврат/создание дополнительного свойства "ИдентификаторКаргомарт"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит идентификатор Каргомарт
Функция РеквизитИдентификаторКаргомарт() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_РеализацияТоваровУслуг);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_ПоступлениеТоваровУслуг);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_СчетНаОплатуПокупателю);
	//МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Справочник_Контрагенты);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Контрагенты"));
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Справочник_Номенклатура);

	НаименованиеРеквизита 	= "Идентификатор Каргомарт";
	ИмяРеквизита 			= "ИдентификаторКаргомарт";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Строка"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,Новый КвалификаторыСтроки(50));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

//Возврат/создание дополнительного свойства "СводныйДокументПоЗаказамКаргомарт"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит сводный документ по заказам Каргомарт
Функция РеквизитСводныйДокументПоЗаказамКаргомарт() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_РеализацияТоваровУслуг);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_ПоступлениеТоваровУслуг);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_СчетНаОплатуПокупателю);

	НаименованиеРеквизита 	= "Сводный документ по заказам Каргомарт";
	ИмяРеквизита 			= "СводныйДокументПоЗаказамКаргомарт";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Булево"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов);
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

// Возврат/создание дополнительного свойства "ВариантОплатыПеревозки"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит вариант оплаты перевозки
Функция РеквизитВариантОплатыПеревозки() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	//МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Справочник_Контрагенты);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Контрагенты"));
	
	НаименованиеРеквизита 	= "Вариант оплаты услуг перевозки";
	ИмяРеквизита 			= "ВариантОплатыПеревозки";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Строка"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,Новый КвалификаторыСтроки(50));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);

КонецФункции

//Возврат/создание дополнительного свойства "ИдентификаторКаргомарт"
// 
// Возвращаемое значение:
//  ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Реквизит идентификатор Каргомарт
Функция РеквизитВидУдостоверяющегоДокументаКонтрагента() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	//МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Справочник_Контрагенты);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Контрагенты"));
	
	НаименованиеРеквизита 	= "Вид документа, удостоверяющего личность";
	ИмяРеквизита 			= "ВидУдостоверяющегоДокумента";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Строка"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,Новый КвалификаторыСтроки(50));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

Функция РеквизитНомерУдостоверяющегоДокументаКонтрагента() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	//МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Справочник_Контрагенты);
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Контрагенты"));
	
	НаименованиеРеквизита 	= "Номер документа, удостоверяющего личность";
	ИмяРеквизита 			= "НомерУдостоверяющегоДокумента";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Строка"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,Новый КвалификаторыСтроки(20));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

Функция РеквизитДатаУдостоверяющегоДокументаКонтрагента() Экспорт
	
	МассивНаборовСведений = Новый Массив;
	МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.НайтиПоНаименованию("Контрагенты"));
	//МассивНаборовСведений.Добавить(Справочники.НаборыДополнительныхРеквизитовИСведений.Справочник_Контрагенты);
	
	НаименованиеРеквизита 	= "Дата документа, удостоверяющего личность";
	ИмяРеквизита 			= "ДатаУдостоверяющегоДокумента";
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Дата"));
	ОписаниеТипаРеквизита = Новый ОписаниеТипов(МассивТипов,,, Новый КвалификаторыДаты(ЧастиДаты.Дата));
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьДопРеквизит(НаименованиеРеквизита, ИмяРеквизита, МассивНаборовСведений, ОписаниеТипаРеквизита);
	
КонецФункции

// Возврат/создание вида контактной информации "Контактный EMail" для справочника "Физические лица".
// 
// Возвращаемое значение:
//  СправочникСсылка.ВидыКонтактнойИнформации - вид "Контактный EMail"
Функция ВКИКонтактныйEMail() Экспорт
	
	ПеречислениеСсылкаТипыКонтактнойИнформации = КМ_ОбщийМодульПовтИсп.МодульЯдро().ПолучитьСсылкиНаОбъектыКонфигурации("Перечисления_ТипыКонтактнойИнформации");
	
	Наименование 		= "Контактный Email";
	ГруппаНаименование 	= "Контактная информация справочника ""Физические лица""";
	
	ДопРеквизиты = Новый Структура;
	ДопРеквизиты.Вставить("ПроверятьКорректность", 	Истина);
	ДопРеквизиты.Вставить("ОбязательноеЗаполнение", Ложь);
	ДопРеквизиты.Вставить("Используется", 			Истина);
	ДопРеквизиты.Вставить("ИдентификаторДляФормул", "КонтактныйEmail");
	
	Возврат КМ_ОбщийМодульВызовСервера.ИнициализироватьВидКонтактнойИнформации(ПеречислениеСсылкаТипыКонтактнойИнформации.АдресЭлектроннойПочты, ГруппаНаименование, Наименование, ДопРеквизиты );
	
Конецфункции

Функция ОпределениеЯдра() Экспорт
	
	ИмяКонфигурации = Метаданные.Имя;
	
	Если ИмяКонфигурации = "БухгалтерияПредприятия" Тогда	
		Возврат "КМ_ОбщийМодуль_БП_epf";		
	Иначе
		Возврат "КМ_ОбщийМодуль_УТ_epf";	
	КонецЕсли;
		
КонецФункции

Функция СтавкаНДСЧислом(СтавкаНДС) Экспорт
	
	ПеречислениеСсылкаСтавкиНДС = КМ_ОбщийМодульПовтИсп.МодульЯдро().ПолучитьСсылкиНаОбъектыКонфигурации("Перечисления_СтавкиНДС");
	
	Если СтавкаНДС = ПеречислениеСсылкаСтавкиНДС.НДС20 Тогда
		Возврат 20;
	ИначеЕсли СтавкаНДС = ПеречислениеСсылкаСтавкиНДС.НДС10 Тогда
		Возврат 10;
	Иначе
		 Возврат 0;
	КонецЕсли;
		
КонецФункции

Функция СтавкаНДСПоЧислу(СтавкаНДС) Экспорт
	
	ПеречислениеСсылкаСтавкиНДС = КМ_ОбщийМодульПовтИсп.МодульЯдро().ПолучитьСсылкиНаОбъектыКонфигурации("Перечисления_СтавкиНДС");
	
	Если СтавкаНДС = 20 Тогда
		Возврат ПеречислениеСсылкаСтавкиНДС.НДС20;
	ИначеЕсли СтавкаНДС = 10 Тогда
		Возврат ПеречислениеСсылкаСтавкиНДС.НДС10;
	Иначе
		 Возврат ПеречислениеСсылкаСтавкиНДС.БезНДС;
	КонецЕсли;
		
КонецФункции

#КонецОбласти