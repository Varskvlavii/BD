NOMER 1
//Создал новый заказ юзера
Select id,zakaz from users
 where coment='-' and ozenka=0
NOMER 2
UPDATE public.users
	SET  coment='nice trip', ozenka=5
	WHERE id=6;
//пустой заказ заполнил оценкой и коментом.
NOMER 3
INSERT INTO public.users(
	id, coment, ozenka, zakaz)
	VALUES (6, '-', 0, 3);
//Создал новый заказ юзера
Select id,zakaz from users
 where coment='-' and ozenka=0
//выбрал новый заказ юзера, будучи водителем
NOMER 4
select from users
	where ozenka>4.8
NOMER 5
INSERT INTO public.voditel(
	id, starts, "time", stop, ozen,pribil)
	VALUES (2, true, 5, false, 0,false);
//Отметил, что он приехал к дому.
NOMER 6
INSERT INTO public.voditel(
	id, starts, "time", stop, ozen,pribil)
	VALUES (2, true, 5, false, 0,false);
//показано, что водитель отметил, что он начал поездку.
NOMER 7
INSERT INTO public.voditel(
	id, starts, "time", stop, ozen,pribil)
	VALUES (4, false, 5, true, 0,false);
//Водитель приехал до пункта назначения.
NOMER 8
//ДОПУСТИМ, ЧТО ЗА 1 МИНУТУ ПОЕЗДКИ ЦЕНА- 50 РУБ
SELECT id, starts, "time", stop, ozen, pribil,"time"*50
	FROM public.voditel;
//ДОБАВЛЕН СТОЛБЕЦ ZENA, В КОТОРОМ РАССЧИТАЛ СТОИМОСТЬ ЗАКАЗА СОГЛАСНО ПРАВИЛУ.
MOMER 10
SELECT * FROM users 
ORDER BY datapoezd;
NOMER 11
SELECT * FROM voditel
ORDER BY timessa;
NOMER 9
// СОЗДАЛ ВРЕМЯ ОТДЕЛЬНО (СТОБЕЦ TIMEPRA)
SELECT * FROM users
ORDER BY clientnum;
//тут идёт сортировка по клиентам
SELECT count(clientnum)
FROM users
	where clientnum=1;
//тут смотрим по определённому клиенту кол-во его поездок например.
	