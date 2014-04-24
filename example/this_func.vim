
function! HomuFunction()
	echo chained#this_func()
	" => HomuFunction
endfunction

function! s:homu_function()
	echo chained#this_func()
	" => <SNR>245_homu_function
endfunction

call HomuFunction()
call s:homu_function()

" 何も返さない
echo chained#this_func()


" 辞書は無理
let s:dict = {}
function! s:dict.func()
	echo chained#this_func()
	" => 670
endfunction
call s:dict.func()


