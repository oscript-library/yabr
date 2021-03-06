///////////////////////////////////////////////////////////////////
//
#Использовать cli
#Использовать tempfiles
#Использовать "."

Перем Лог;
Перем ВыводДополнительнойИнформации;
Перем ВременныйКаталогРаботы;

///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()

	МенеджерОбработкиДанных = Новый МенеджерОбработкиДанных();

	МенеджерОбработкиДанных.ДобавитьРабочийКаталог("$yabrDir", ТекущийСценарий().Каталог);

	Приложение = Новый КонсольноеПриложение(ПараметрыПриложения.ИмяПриложения(),
											"приложение для обработки файлов скобочного формата 1С");
	Приложение.Версия("version", ПараметрыПриложения.Версия());

	Приложение.ДобавитьКоманду("process p", "Запускает обработку данных по указанной настройке (json)",
	                           МенеджерОбработкиДанных);
	Приложение.ДобавитьКоманду("test t", "Запускает тестовое чтение файла в скобочном формате 1С",
							   Новый Тест());
	Приложение.Опция("v verbose", Ложь, "вывод отладочной информации в процессе выполнения")
			  .Флаговый();
	
	Приложение.Запустить(АргументыКоманднойСтроки);
						
КонецПроцедуры // ВыполнитьПриложение()

///////////////////////////////////////////////////////

Лог = ПараметрыПриложения.Лог();

Попытка

	ВыполнитьПриложение();

Исключение

	Лог.КритичнаяОшибка(ОписаниеОшибки());
	ВременныеФайлы.Удалить();

	ЗавершитьРаботу(1);

КонецПопытки;
