

" スクリプトローカル関数で使用できる
function! s:local_function_scope()
	" 関数名を取得
	echo chained#function_name()
	" => homu_func

	" SID を取得
	echo chained#SID()
	" => 404

	" SNR を含んだ関数名の取得
	echo chained#function_symbol()
	" => <SNR>404_homu_func

	" <SNR>{SID}_ の取得
	echo chained#SNR()
	" => <SNR>404_
endfunction
call s:local_function_scope()


" グローバル関数の場合
function! g:global_function_scope()
	" 関数名を取得
	echo chained#function_name()
	" => g:global_function_scope

	" SID は取得できない
	echo chained#SID()
	" => ""

	" chained#function_name() と同様
	echo chained#function_symbol()
	" => g:global_function_scope
endfunction
call g:global_function_scope()


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
	" => ['<SNR>404_call_func1', '<SNR>404_call_func2', 'g:call_func3', '<SNR>404_call_func4']

	" 1つ前の関数を取得する
	echo chained#called_func(1)
	" => g:call_func3

	echo chained#called_func(0)
	" => <SNR>404_call_func4
endfunction

function! g:call_func3()
	call s:call_func4()
endfunction

function! s:call_func2()
	call g:call_func3()
endfunction

function! s:call_func1()
	call s:call_func2()
endfunction
call s:call_func1()





