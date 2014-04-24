

" スクリプトローカル関数で使用できる
function! s:local_function_scope()
	" 関数名を取得
	echo chained#function_name()
	" => local_function_scope

	" SID を取得
	echo chained#SID()
	" => 283

	" SNR を含んだ関数名の取得
	echo chained#function_symbol()
	" => <SNR>283_local_function_scope

	" <SNR>{SID}_ の取得
	echo chained#SNR()
	" => <SNR>283_
endfunction
call s:local_function_scope()


" グローバル関数の場合
function! Global_function_scope()
	" 関数名を取得
	echo chained#function_name()
	" => Global_function_scope

	" SID は取得できない
	echo chained#SID()
	" => ""

	" chained#function_name() と同様
	echo chained#function_symbol()
	" => Global_function_scope
endfunction
call Global_function_scope()


" 変換
function! s:to_xxx()
	let symbol = chained#function_symbol()

	echo symbol
	" <SNR>404_to_xxx

	echo chained#to_function_name(symbol)
	" => to_xxx
	
	echo chained#to_SID(symbol)
	" => 404
	
	echo chained#to_SNR(symbol)
	" => <SNR>404_
endfunction
call s:to_xxx()


" 関数の呼び出し履歴を取得
function! s:call_func4()
	" 呼び出し履歴
	" 左から順番に呼ばれた関数のリスト
	echo chained#call_stack()
	" => ['<SNR>283_call_func1', '<SNR>283_call_func2', 'Call_func3', '<SNR>283_call_func4']

	" 1つ前の関数を取得する
	echo chained#called_func(1)
	" => Call_func3

	echo chained#called_func(0)
	" => <SNR>283_call_func4
endfunction

function! Call_func3()
	call s:call_func4()
endfunction

function! s:call_func2()
	call Call_func3()
endfunction

function! s:call_func1()
	call s:call_func2()
endfunction
call s:call_func1()





