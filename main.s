	.file	"main.c"
	.intel_syntax noprefix
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	read_array
	.type	read_array, @function

	# функция чтения массива, принимает на вход два параметра array, size
read_array:
	push	rbp							# типовое начало функции
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi			# rbp-24 := array
	mov	DWORD PTR [rbp-28], esi			# rbp-28 := size
	mov	DWORD PTR [rbp-4], 0  			# i := 0
	jmp	.L2   							# переходи к условию for-а
.L3:
	mov	eax, DWORD PTR [rbp-4]			# eax := i
	cdqe
	lea	rdx, [0+rax*4]					# rdx := rax * 4 = i * 4
	mov	rax, QWORD PTR [rbp-24]			# rax := array 
	add	rax, rdx						# rax += rdx    | в rax лежит &array[i]
	mov	rsi, rax						# второй аргумент - &array[i]
	mov	edi, OFFSET FLAT:.LC0			# первый аргумент - "%d"
	mov	eax, 0                          # 
	call	__isoc99_scanf				# scanf("%d", &array[i]);
	add	DWORD PTR [rbp-4], 1 			# ++i
.L2:									# 
	mov	eax, DWORD PTR [rbp-4]			# i
	cmp	eax, DWORD PTR [rbp-28]			# сравнить i и size
	jl	.L3 							# если i < size то заходим в цикл
	nop 								# ничего не делает
	leave								# move rsp rbp, pop rbp
	ret									# передаем управление вызывающей функции, ничего не возврощать тк тиап void






	.size	read_array, .-read_array
	.globl	count_valid
	.type	count_valid, @function

	# функция подсчета элементов, подходящих под условие задачи
	# т.е. тех, что не равны первому и последнему
	# принимает на вход два значение 
count_valid:
	push	rbp							# типовое начало
	mov	rbp, rsp
	mov	QWORD PTR [rbp-24], rdi			# rbp-24 := array
	mov	DWORD PTR [rbp-28], esi			# rbp-28 := size
	mov	DWORD PTR [rbp-8], 0 			# result_len  := 0
	mov	DWORD PTR [rbp-4], 0 			# i := 0
	jmp	.L6 							# переходим к условию for-a
.L8:
	mov	eax, DWORD PTR [rbp-4]			# eax := i
	cdqe								# eax -> rax
	lea	rdx, [0+rax*4]					# rdx := rax * 4 = i * sizeof(int)
	mov	rax, QWORD PTR [rbp-24]			# rax := array
	add	rax, rdx						# rax += rdx  <-> rax = &array[i]
	mov	edx, DWORD PTR [rax]			# edx = *rax = array[i]
	mov	rax, QWORD PTR [rbp-24]			# rax := array
	mov	eax, DWORD PTR [rax]			# eax := *array = array[0]
	cmp	edx, eax						# сравнить array[0] и array[i]
	je	.L7 							# array[0] == array[i] -> array[i] не подходит по условию и не считаем его
	mov	eax, DWORD PTR [rbp-4]			# в блоке команд ниже кладем в edx array[i]
	cdqe								# 
	lea	rdx, [0+rax*4]					#
	mov	rax, QWORD PTR [rbp-24]			# этот блок повторяет то, что написано наверху
	add	rax, rdx						#
	mov	edx, DWORD PTR [rax]			# edx := array[i]
	mov	eax, DWORD PTR [rbp-28]			# в блоке команд ниже кладем в eax array[size - 1]
	cdqe								#
	sal	rax, 2 							#
	lea	rcx, [rax-4]					#
	mov	rax, QWORD PTR [rbp-24]			#
	add	rax, rcx						#
	mov	eax, DWORD PTR [rax]			# eax := *(&array[size - 1]) = array[size - 1]
	cmp	edx, eax						# сравнить edx и eax (array[i] и array[n - 1])
	je	.L7 							# если array[i] == array[n - 1], то array[i] нам не подходит
	add	DWORD PTR [rbp-8], 1 			# ++result_len
.L7:
	add	DWORD PTR [rbp-4], 1     		# ++i
.L6:	
	mov	eax, DWORD PTR [rbp-4]			# eax := i
	cmp	eax, DWORD PTR [rbp-28]			# сравнить i и size;
	jl	.L8								# i < size -> выполнить тело цикла
	mov	eax, DWORD PTR [rbp-8] 			# возвращаемое значение result_len
	pop	rbp
	ret									# выйти из функции





	.size	count_valid, .-count_valid
	.globl	push_valid
	.type	push_valid, @function
push_valid:
	push	rbp							# типовое начало функции
	mov	rbp, rsp
	mov	QWORD PTR [rbp-24], rdi			# rbp-24 := result
	mov	QWORD PTR [rbp-32], rsi			# rbp-32 := array
	mov	DWORD PTR [rbp-36], edx			# rbp-36 := size
	mov	DWORD PTR [rbp-8], 0 			# j := 0
	mov	DWORD PTR [rbp-4], 0 			# i := 0
	jmp	.L11							# переходим к условию for-a
.L13:
	mov	eax, DWORD PTR [rbp-4]			# в блоке команд ниже кладем в edx array[i]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]			# edx := array[i]
	mov	rax, QWORD PTR [rbp-32]			# 
	mov	eax, DWORD PTR [rax]			# eax := array[0]
	cmp	edx, eax			
	je	.L12							# элемент не подходит под условие задачи, не добавляем его в result
	mov	eax, DWORD PTR [rbp-4]			# кладем в edx array[i]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]			# edx := array[i]
	mov	eax, DWORD PTR [rbp-36] 		# кладем в eax array[size - 1]
	cdqe
	sal	rax, 2
	lea	rcx, [rax-4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]			# eax := array[size - 1]
	cmp	edx, eax
	je	.L12							# элемент не подходит под условие задачи, не добавляем его в result
	mov	eax, DWORD PTR [rbp-8]			# eax := j 				| в эти трех строках происходит j++ 
	lea	edx, [rax+1]					# edx := j + 1 			| в rax мы храним старое значение, в edx храним новое значение
	mov	DWORD PTR [rbp-8], edx			# rbp-8 := j 			| и обновляем значение на стеке
	cdqe 								# eax -> rax
	lea	rdx, [0+rax*4] 					# j * sizeof(int) - смещение от начала массива
	mov	rax, QWORD PTR [rbp-24] 		# rax := result 
	add	rdx, rax						# rdx += rax <- в rdx храним указатель на array[j] 
	mov	eax, DWORD PTR [rbp-4] 			# кладем в eax array[i]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]			# eax := array[i]
	mov	DWORD PTR [rdx], eax			# result[j] := array[i]
.L12:
	add	DWORD PTR [rbp-4], 1  			# ++i;
.L11:
	mov	eax, DWORD PTR [rbp-4] 			# eax := i
	cmp	eax, DWORD PTR [rbp-36] 		# сравниваем i и size
	jl	.L13 							# i < size -> перейти к телу цикла
	nop 								# ничего не делает
	pop	rbp
	ret									# функция типа  void ничего не возвращает




	.size	push_valid, .-push_valid
	.section	.rodata
.LC1:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
# функция print_array
print_array:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi 		# сохранили на стеке array 
	mov	DWORD PTR [rbp-28], esi			# сохранили на стеке size
	mov	DWORD PTR [rbp-4], 0 			# i := 0
	jmp	.L16							# переходим к условию for-a
.L17:
	mov	eax, DWORD PTR [rbp-4] 			# eax := i
	cdqe								# eax -> rax
	lea	rdx, [0+rax*4]					# сохраняем в rdx смещение (i * sizeof(int))
	mov	rax, QWORD PTR [rbp-24]			# rax := array
	add	rax, rdx						# rax := &array[i]
	mov	eax, DWORD PTR [rax]			# eax := *rax = array[i] // разыменовываем указатель
	mov	esi, eax						# esi := eax = array[i]
	mov	edi, OFFSET FLAT:.LC1			# edi = "%d " // для вывода
	mov	eax, 0 							# подобно scanf тут нет переменного числа аргументов (в al количество векторных регистров, используемых для хранения аргументов)
	call	printf						# printf("%d ", array[i]);
	add	DWORD PTR [rbp-4], 1 			# ++i
.L16:
	mov	eax, DWORD PTR [rbp-4] 			# eax := i
	cmp	eax, DWORD PTR [rbp-28]			# сравнить i и size
	jl	.L17							# если  i < size -> в тело цикла
	nop 								# ничего не делает
	leave								# 
	ret									# функция типа  void ничего не возвращает




# Переменные на стеке по смещениям
# -32 | n
# -24 | array
# -28 | result_len
# -16 | result
# 
	.size	print_array, .-print_array
	.globl	main
	.type	main, @function
main:									# начало программы, отсюда все начинается
	push	rbp						 	# кладем указатель на начало стека вызывающей фукнции
	mov	rbp, rsp						# начало нашего стека - это конец вызывающего
	sub	rsp, 32							# занимаем 32 бита памяти
	lea	rax, [rbp-32]					# rax := &n 	| указатель на переменную n
	mov	rsi, rax						# rsi := &n 	| второй параметр вызова функции scanf
	mov	edi, OFFSET FLAT:.LC0			# edi := "%d" 	| первый параметр вызова функции scanf
	mov	eax, 0 							# фунция scanf принимает переменное число аргументов и в al лежит это число
	call	__isoc99_scanf				# вызываем функцию, считываем n 

	mov	eax, DWORD PTR [rbp-32]     	# eax := n
	cdqe								# расширение eax до восьмибайтового
	sal	rax, 2 							# байтовый сдвиг на 2(sizeof(int)) влево, что равносильно умножению на 4; 
	mov	rdi, rax						# первый параметр вызова функции malloc rdi := n * sizeof(int)
	call	malloc						# вызов функции, выделяем память под массив array
	
	mov	QWORD PTR [rbp-24], rax			# rbp-24 - тут на стеке у нас теперь лежит array
	mov	edx, DWORD PTR [rbp-32]			# edx := n 
#	mov	rax, QWORD PTR [rbp-24] 		# она и так там лежит 
	mov	esi, edx						# esi := n
	mov	rdi, rax						# rdi := result_len * sizeof(int)
	call	read_array					# вызываем функцию чтения с аргументами rdi, esi, а точнее read_array(array, n)

	mov	edx, DWORD PTR [rbp-32]			# edx := n
	mov	rax, QWORD PTR [rbp-24]			# rax := array
	mov	esi, edx						# esi := edx := n
	mov	rdi, rax						# rdi := rax = array
	call	count_valid					# вызываем функцию подсчета с аргументами rdi, esi, а точнее count_valid(array, n)

	mov	DWORD PTR [rbp-28], eax			# сохраняем результат функции count_valid на стеке в rbp-28 (result_len)
#	mov	eax, DWORD PTR [rbp-28]			# оно и так там лежит
	cdqe								# расширение eax до восьмибайтового
	sal	rax, 2 							# rax := rax << 2 == rax * 4 == rax * sizeof(int)
	mov	rdi, rax						# rdi := result_len * sizeof(int)
	call	malloc						# выделение памяти под массив result подобно массиву array

	mov	QWORD PTR [rbp-16], rax			# rbp-16 - тут у нас на стеке лежит result
	mov	edx, DWORD PTR [rbp-32]			# edx := n
	mov	rcx, QWORD PTR [rbp-24]			# rcx := array
#	mov	rax, QWORD PTR [rbp-16]			# rax := result, но и так уже там
	mov	rsi, rcx						# rsi := rcx == array 
	mov	rdi, rax						# rdi := rax == result
	call	push_valid					# вызов функции заполнения result с аргументами rdi, rsi, edx, а точнее push_valid(result, array, n)

	mov	edx, DWORD PTR [rbp-28]			# edx := result_len
	mov	rax, QWORD PTR [rbp-16]			# rax := result
	mov	esi, edx						# esi := radx == result_len	
	mov	rdi, rax						# rdi := rax == result
	call	print_array					# вызов функции вывода массива с аргументами rdi, esi, а точнее print_array(result, result_len)

	mov	rax, QWORD PTR [rbp-24]			# rax := array
	mov	rdi, rax						# rdi := rax == array
	call	free						# очищаем память за собой с помощью вызова функции free(array);

	mov	rax, QWORD PTR [rbp-16]			# rax := result
	mov	rdi, rax						# rdi := rax == result
	call	free						# очищаем память за собой с помощью

	mov	eax, 0  						# показываем вызывающей функции, что всё прошло ок

	leave								# возвращем rbp на место начала области стековой памяти вызывающей функции
	ret									# переносим управление обратно в вызывающую функцию
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
