&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	мОбъект = РеквизитФормыВЗначение("Объект");
	мОбъект.ДобавитьМеню(ЭтаФорма,"xUnit");
	ЭтаФорма.КоманднаяПанель.Видимость = Ложь;
	ЭтаФорма.АвтоЗаголовок = Ложь;
	ЭтаФорма.Заголовок = "xUnit";
	
	
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ТестируемыйКлиент",Справочники.ТестируемыеКлиенты.ПустаяСсылка());
	СписокТестов.Параметры.УстановитьЗначениеПараметра("Проверка",Справочники.Проверки.ПустаяСсылка());
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборПадения",ОтборПадения);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборОшибки",ОтборОшибки);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборПропуски",ОтборПропуски);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборУспешные",ОтборУспешные);

	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ТестируемыйКлиент",Справочники.ТестируемыеКлиенты.ПустаяСсылка());
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("Тест",Справочники.Тесты.ПустаяСсылка());
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("Проверка",Справочники.Проверки.ПустаяСсылка());
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборПадения",ОтборПадения);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборОшибки",ОтборОшибки);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборПропуски",ОтборПропуски);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборУспешные",ОтборУспешные);
	
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ТестируемыйКлиент",Справочники.ТестируемыеКлиенты.ПустаяСсылка());
	СписокШагов.Параметры.УстановитьЗначениеПараметра("Тест",Справочники.Тесты.ПустаяСсылка());
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ТестовыйСлучай",Неопределено);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("Проверка",Справочники.Проверки.ПустаяСсылка());
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборПадения",ОтборПадения);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборОшибки",ОтборОшибки);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборПропуски",ОтборПропуски);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборУспешные",ОтборУспешные);	

	ЗаполнитьЗначенияСвойств(Объект,Параметры);
	
КонецПроцедуры


&НаКлиенте
Процедура СписокШаговПриАктивизацииСтроки(Элемент)
	ТекущиеДанные = Элементы.СписокШагов.ТекущиеДанные;
	Если ТекущиеДанные=Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ТекущиеДанные.ЕстьПриложение=Истина Тогда
		//Элементы.ГруппаКартинка.Видимость = Истина;
		Источник = новый Структура("Проверка,ТестируемыйКлиент,Тест,ТестовыйСлучай,Шаг",Объект.Проверка,Объект.ТестируемыйКлиент,ТекущиеДанные.Тест,ТекущиеДанные.ТестовыйСлучай,ТекущиеДанные.Шаг);
		Картинка = ОтобразитьКартинку(Источник);	
		//Элементы.ГруппаКартинка.Ширина = 50;
		//Элементы.ГруппаТесты.Ширина = 4;
		//Элементы.ГруппаСлучаи.Ширина = 4;
	Иначе
		//Элементы.ГруппаКартинка.Видимость = Ложь;
		Картинка = "";
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОтобразитьКартинку(Источник)
	
	HTML = ""; 
	
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Т.Номер,
	|	Т.Приложение,
	|	Т.ТипФайла,
	|	Т.ИмяФайла,
	|	Т.Размер
	|ИЗ
	|	РегистрСведений.ПриложенияПротоколовВыполненияТестов КАК Т
	|ГДЕ
	|	Т.Проверка = &Проверка
	|	И Т.ТестируемыйКлиент = &ТестируемыйКлиент
	|	И Т.Тест = &Тест
	|	И Т.ТестовыйСлучай = &ТестовыйСлучай
	|	И Т.Шаг = &Шаг";
	Запрос.УстановитьПараметр("Проверка",Источник.Проверка );
	Запрос.УстановитьПараметр("ТестируемыйКлиент",Источник.ТестируемыйКлиент );
	Запрос.УстановитьПараметр("Тест",Источник.Тест );
	Запрос.УстановитьПараметр("ТестовыйСлучай",Источник.ТестовыйСлучай );
	Запрос.УстановитьПараметр("Шаг",Источник.Шаг );
	
	Выборка = ЗАпрос.Выполнить().Выбрать();
	Картинка = "";
	
	Пока Выборка.Следующий() Цикл
		
		Попытка
			Если ТипЗнч(Выборка.Приложение)=Тип("ХранилищеЗначения") Тогда
				СсылкаНаКартинку = ПоместитьВоВременноеХранилище(Новый Картинка(Выборка.Приложение.Получить()),новый УникальныйИдентификатор);
				Картинка = Картинка+"<IMG style='' src='"+СсылкаНаКартинку+"'><br />";
			КонецЕсли;
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
		
		
	КонецЦикла;
	
	HTML = "<html><head></head><body>"+Картинка+"</body></html>";
	
	Возврат HTML;
КонецФункции

&НаКлиенте
Процедура ПанельСКартинками(Команда)
	Если Элементы.ПанельСКартинками.Пометка = Ложь Тогда
		Элементы.ПанельСКартинками.Картинка=БиблиотекаКартинок.Screenshot_gray_32х32;
		Элементы.ПанельСКартинками.Пометка = Истина;
		Элементы.ГруппаКартинка.Видимость = Ложь;
	Иначе
		Элементы.ПанельСКартинками.Картинка=БиблиотекаКартинок.Screenshot_32х32;
		Элементы.ПанельСКартинками.Пометка = Ложь;
		Элементы.ГруппаКартинка.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КартинкиНаПолныйЭкранИОбратно(Команда)
		
		Если Элементы.КартинкиНаПолныйЭкранИОбратно.ЦветФона = новый Цвет() Тогда
			Элементы.КартинкиНаПолныйЭкранИОбратно.ЦветФона = новый Цвет(155,155,155);
			
			Элементы.ГруппаТесты.Видимость = Ложь;
			Элементы.СтраницаИнформация.Видимость = Ложь;
			Элементы.Группа5.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
			Элементы.ГруппаТестовыеСлучаи.Видимость = Ложь;		
			Элементы.ПанельСКартинками.Видимость = Ложь;
			
			Если Элементы.ПанельСКартинками.Пометка = Истина Тогда
				Элементы.ПанельСКартинками.Картинка=БиблиотекаКартинок.Screenshot_32х32;
				Элементы.ПанельСКартинками.Пометка = Ложь;
				Элементы.ГруппаКартинка.Видимость = Истина;				
			КонецЕсли;
			
		Иначе
			Элементы.КартинкиНаПолныйЭкранИОбратно.ЦветФона = новый Цвет();
			
			Элементы.ГруппаТесты.Видимость = Истина;
			Элементы.СтраницаИнформация.Видимость = Истина;
			Элементы.Группа5.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСверху;	
			Элементы.ГруппаТестовыеСлучаи.Видимость = Истина;
			Элементы.ПанельСКартинками.Видимость = Истина;	
			
		КонецЕсли;

КонецПроцедуры




&НаКлиенте
Процедура КнопкаМеню(Команда)
	ИмяКоманды = Команда.Имя;
	мПараметры = новый Структура("Проверка,ТестируемыйКлиент",Объект.Проверка,Объект.ТестируемыйКлиент);
	ОткрытьФорму("ВнешняяОбработка.AllureSkin.Форма."+ИмяКоманды,мПараметры,ЭтаФорма,ЭтаФорма.УникальныйИдентификатор,ЭтаФорма.Окно);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЗагрузитьНастройкиПользователя();
	УстановитьОтборыСпискаТестов();

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьНастройкиПользователя()
	
	мОбъект = РеквизитФормыВЗначение("Объект");
	
	МассивНаименованийНастроек = новый Массив;
	МассивНаименованийНастроек.Добавить("ОтборОшибки");
	МассивНаименованийНастроек.Добавить("ОтборПадения");
	МассивНаименованийНастроек.Добавить("ОтборПропуски");
	МассивНаименованийНастроек.Добавить("ОтборУспешные");
	
	Для каждого ИмяНастройки из МассивНаименованийНастроек Цикл
		
		ЗначениеНастройки = мОбъект.ЗагрузитьНастройкиПользователя(Объект,ИмяНастройки);		
		Если ЗначениеНастройки<>Неопределено Тогда
			ЭтаФорма[ИмяНастройки] = ЗначениеНастройки;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьПоследнююПроверкуДляТестируемогоКлиента(Знач ТестируемыйКлиент)
	
	Проверка = Справочники.Проверки.ПустаяСсылка();
	
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	Т.Проверка КАК Проверка
	|ИЗ
	|	РегистрСведений.ПротоколыВыполненияТестов КАК Т
	|ГДЕ
	|	Т.ТестируемыйКлиент = &ТестируемыйКлиент
	|
	|УПОРЯДОЧИТЬ ПО
	|	Т.Проверка.Код УБЫВ";
	Запрос.УстановитьПараметр("ТестируемыйКлиент",ТестируемыйКлиент);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		
		Если Выборка.Следующий() Тогда
			Проверка = Выборка.Проверка;
		КонецЕсли;
		
	КонецЕсли;
	
	
	Возврат Проверка;
	
КонецФункции

&НаКлиенте
Процедура ТестируемыйКлиентПриИзменении(Элемент)
	
	СохранитьНастройкиПользователя();
	УстановитьОтборыСпискаТестов();

КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборыСпискаТестов()
	
	Если НЕ ЗначениеЗаполнено(ВидСписка_Случаи) Тогда
		ВидСписка_Случаи = "Список";
	КонецЕсли;       	

	Элементы.ВидСписка_Случаи.РежимВыбораИзСписка = Истина;
	Элементы.ВидСписка_Случаи.РедактированиеТекста = Ложь;	
	Элементы.ВидСписка_Случаи.СписокВыбора.Очистить();
	Элементы.ВидСписка_Случаи.СписокВыбора.Добавить("Список");
	Элементы.ВидСписка_Случаи.СписокВыбора.Добавить("Дерево");
	
	Объект.Проверка = ПолучитьПоследнююПроверкуДляТестируемогоКлиента(Объект.ТестируемыйКлиент);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ТестируемыйКлиент",Объект.ТестируемыйКлиент);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("Проверка",Объект.Проверка);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборПадения",ОтборПадения);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборОшибки",ОтборОшибки);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборПропуски",ОтборПропуски);
	СписокТестов.Параметры.УстановитьЗначениеПараметра("ОтборУспешные",ОтборУспешные);
	
	Элементы.Падения.ЦветФона = ?(ОтборПадения,новый Цвет(190,190,190),новый Цвет(255,255,255));
	Элементы.Ошибки.ЦветФона = ?(ОтборОшибки,новый Цвет(190,190,190),новый Цвет(255,255,255));
	Элементы.Пропуски.ЦветФона = ?(ОтборПропуски,новый Цвет(190,190,190),новый Цвет(255,255,255));
	Элементы.Успешные.ЦветФона = ?(ОтборУспешные,новый Цвет(190,190,190),новый Цвет(255,255,255));

КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборыСпискаСлучаев()
	
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("Тест",ТекущийТест);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ТестируемыйКлиент",Объект.ТестируемыйКлиент);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("Проверка",ПолучитьПоследнююПроверкуДляТестируемогоКлиента(Объект.ТестируемыйКлиент));
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборПадения",ОтборПадения);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборОшибки",ОтборОшибки);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборПропуски",ОтборПропуски);
	СписокСлучаев.Параметры.УстановитьЗначениеПараметра("ОтборУспешные",ОтборУспешные);

	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборыСпискаШагов()
	
	СписокШагов.Параметры.УстановитьЗначениеПараметра("Тест",ТекущийТест);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ТестовыйСлучай",ТекущийТестовыйСлучай);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ТестируемыйКлиент",Объект.ТестируемыйКлиент);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("Проверка",ПолучитьПоследнююПроверкуДляТестируемогоКлиента(Объект.ТестируемыйКлиент));
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборПадения",ОтборПадения);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборОшибки",ОтборОшибки);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборПропуски",ОтборПропуски);
	СписокШагов.Параметры.УстановитьЗначениеПараметра("ОтборУспешные",ОтборУспешные);
	
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройкиПользователя(ИмяНастройки="",ЗначениеНастройки="")
	
	мОбъект = РеквизитФормыВЗначение("Объект");
	мОбъект.СохранитьНастройкиПользователя(Объект,ИмяНастройки,ЗначениеНастройки);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНастройкиЭлемента(ИмяЭлемента)
	
	Если НЕ ЗначениеЗаполнено(ИмяЭлемента) Тогда
		Возврат;
	КонецЕсли;
	
	СохранитьНастройкиПользователя(ИмяЭлемента,ЭтаФорма[ИмяЭлемента]);	
	
КонецПроцедуры

&НаКлиенте
Процедура Падения(Команда)
	ОтборПадения=НЕ ОтборПадения;
	УстановитьОтборыСпискаТестов();
	УстановитьОтборыСпискаСлучаев();
	УстановитьОтборыСпискаШагов();
	СохранитьНастройкиЭлемента("ОтборПадения");
КонецПроцедуры

&НаКлиенте
Процедура Ошибки(Команда)
	ОтборОшибки=НЕ ОтборОшибки;
	УстановитьОтборыСпискаТестов();
	УстановитьОтборыСпискаСлучаев();
	УстановитьОтборыСпискаШагов();
	СохранитьНастройкиЭлемента("ОтборОшибки");
КонецПроцедуры

&НаКлиенте
Процедура Пропуски(Команда)
	ОтборПропуски=НЕ ОтборПропуски;
	УстановитьОтборыСпискаТестов();
	УстановитьОтборыСпискаСлучаев();
	УстановитьОтборыСпискаШагов();
	СохранитьНастройкиЭлемента("ОтборПропуски");
КонецПроцедуры

&НаКлиенте
Процедура Успешные(Команда)
	ОтборУспешные=НЕ ОтборУспешные;
	УстановитьОтборыСпискаТестов();
	УстановитьОтборыСпискаСлучаев();
	УстановитьОтборыСпискаШагов();
	СохранитьНастройкиЭлемента("ОтборУспешные");
КонецПроцедуры

&НаКлиенте
Процедура СписокТестовПриАктивизацииСтроки(Элемент)
	ТекущиеДанные = Элементы.СписокТестов.ТекущиеДанные;
	
	Если ТекущиеДанные=Неопределено Тогда
		ТекущийТест = Неопределено;
		//Элементы.ГруппаСлучаи.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.Свойство("Тест") Тогда
		ТекущийТест = ТекущиеДанные.Тест;
	Иначе
		ТекущийТест = ПредопределенноеЗначение("Справочник.Тесты.ПустаяСсылка");
	КонецЕсли;
	
	
	УстановитьОтборыСпискаСлучаев();
	УстановитьОтборыСпискаШагов();
	
	Если НЕ КлючТекущейСтрокиТестов=ПолучитьКлючТекущейСтрокиПоДанным("СписокТестов")
		И Элементы.ГруппаСлучаи.Видимость=Ложь Тогда
		Элементы.ГруппаСлучаи.Видимость = Истина;
		КлючТекущейСтрокиТестов = "";
	КонецЕсли;
	
	СписокСлучаевПриАктивизацииСтроки(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура СкрытьСлучаи(Команда)
	Элементы.ГруппаСлучаи.Видимость = Ложь;
	КлючТекущейСтрокиТестов = ПолучитьКлючТекущейСтрокиПоДанным("СписокТестов");
	
КонецПроцедуры

&НаКлиенте
Процедура СкрытьДетализацию(Команда)
	
	Элементы.ГруппаДетализация.Видимость = Ложь;
	КлючТекущейСтрокиСлучаев = ПолучитьКлючТекущейСтрокиПоДанным("СписокСлучаев");
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСлучаевПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.СписокСлучаев.ТекущиеДанные;   
	
	Если ТекущиеДанные=Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ КлючТекущейСтрокиСлучаев=ПолучитьКлючТекущейСтрокиПоДанным("СписокСлучаев")
		И Элементы.ГруппаДетализация.Видимость=Ложь Тогда
		Элементы.ГруппаДетализация.Видимость = Истина;
		КлючТекущейСтрокиСлучаев = "";
	КонецЕсли;

	
	ИнформацияHTML = СформироватьИнформациюHTML(ТекущиеДанные.ТестовыйСлучай,ТекущиеДанные.ОписаниеОшибки,ТекущиеДанные.РезультатВыполнения);
	
	ТекущийТестовыйСлучай = ТекущиеДанные.ТестовыйСлучай;
	
	//Если ТекущиеДанные.КоличествоШагов=0 Тогда
	//	Элементы.СтраницаШаги.Видимость = Ложь;
	//Иначе
	//	Элементы.СтраницаШаги.Видимость = Истина;
	//КонецЕсли;
	УстановитьОтборыСпискаШагов();
	
КонецПроцедуры

&НаКлиенте
Функция СформироватьИнформациюHTML(Знач Представление,Знач Информация, Знач Статус)
	
	HTML = "<html><head></head><body>";
	
	HTML = HTML+"<h2>"+Представление+" ("+Статус+")</h2>";
	Информация = СтрЗаменить(Информация,"Шаг №","</br><hr>Шаг №");
	HTML = HTML+Информация;	
	Если Найти(Информация,"Шаг №") Тогда
		HTML = HTML+"</br><hr>";
	КонецЕсли;	
	
	HTML = HTML+"</body></html>";
	
	Возврат HTML;
	
КонецФункции

&НаКлиенте
Функция ПолучитьКлючТекущейСтрокиПоДанным(ИмяСписка)
	
	Ключ = "";
	мТест = ПредопределенноеЗначение("Справочник.Тесты.ПустаяСсылка");
	
	ТекущиеДанные = Элементы[ИмяСписка].ТекущиеДанные;
	ТекущаяСтрока = Элементы[ИмяСписка].ТекущаяСтрока;
	Если ТекущиеДанные.Свойство("Тест") Тогда
		мТест = ТекущиеДанные.Тест;
	КонецЕсли;
	Если ТипЗнч(мТест)=Тип("СправочникСсылка.Тесты") Тогда
		Ключ = Строка(мТест.UUID())+" "+Строка(ТекущаяСтрока);
	Иначе
		Ключ = Строка(мТест)+" "+Строка(ТекущаяСтрока);
	КонецЕсли;
	
	Возврат Ключ;
	
КонецФункции

&НаКлиенте
Процедура ОбновитьВсе(Команда)
	Элементы.СписокТестов.Обновить();
КонецПроцедуры
