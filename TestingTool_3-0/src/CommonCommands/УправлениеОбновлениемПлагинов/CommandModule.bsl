
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ВыполняемаяКоманда = ПолучитьКомандуОбработки();
	Если ВыполняемаяКоманда=Неопределено Тогда
		Сообщить("В базу не подгружена обработка 'управления обновлениями плагинов'. Загрузите ее в ручном режиме, после этого данный функционал будет доступен.");
	Иначе
		ДополнительныеОтчетыИОбработкиКлиент.ВыполнитьОткрытиеФормыОбработки(ВыполняемаяКоманда,Неопределено,Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьКомандуОбработки()
	
	ВыполняемаяКоманда = Неопределено;
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	ДополнительныеОтчетыИОбработкиКоманды.Ссылка,
	|	ДополнительныеОтчетыИОбработкиКоманды.НомерСтроки,
	|	ДополнительныеОтчетыИОбработкиКоманды.Идентификатор,
	|	ДополнительныеОтчетыИОбработкиКоманды.ВариантЗапуска,
	|	ДополнительныеОтчетыИОбработкиКоманды.Представление,
	|	ДополнительныеОтчетыИОбработкиКоманды.ПоказыватьОповещение,
	|	ДополнительныеОтчетыИОбработкиКоманды.Модификатор,
	|	ДополнительныеОтчетыИОбработкиКоманды.РегламентноеЗаданиеGUID,
	|	ДополнительныеОтчетыИОбработкиКоманды.Скрыть,
	|	ДополнительныеОтчетыИОбработкиКоманды.ЗаменяемыеКоманды,
	|	ДополнительныеОтчетыИОбработкиКоманды.ПросмотрВсе,
	|	ДополнительныеОтчетыИОбработкиКоманды.Описание
	|ИЗ
	|	Справочник.ДополнительныеОтчетыИОбработки.Команды КАК ДополнительныеОтчетыИОбработкиКоманды
	|ГДЕ
	|	ДополнительныеОтчетыИОбработкиКоманды.Ссылка.ИмяОбъекта = &ИмяОбъекта
	|	И ДополнительныеОтчетыИОбработкиКоманды.Ссылка.ПометкаУдаления = ЛОЖЬ";
	Запрос.УстановитьПараметр("ИмяОбъекта","УправлениеОбновлениемПлагинов");
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ВыполняемаяКоманда = новый Структура("Ссылка,НомерСтроки,Идентификатор,ВариантЗапуска,
		|Представление,ПоказыватьОповещение,Модификатор,РегламентноеЗаданиеGUID,Скрыть,ЗаменяемыеКоманды,ПросмотрВсе,Описание");
		ЗаполнитьЗначенияСвойств(ВыполняемаяКоманда,Выборка);
		ВыполняемаяКоманда.Вставить("ЭтоОтчет",Ложь);
	КонецЕсли;
	
	Возврат ВыполняемаяКоманда;
	
КонецФункции