
function! s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun


function! s:test_called_func2(called)
	Assert chained#called_func(0) == chained#function_symbol()
	Assert chained#called_func(1) == a:called
	Assert chained#called_func(100) == ""
endfunction


function! s:test_called_func()
	Assert chained#called_func(0) == chained#function_symbol()
	call s:test_called_func2(chained#called_func(0))
endfunction



function! s:test_to_function_name()
	let this_func = expand("<sfile>")
	Assert chained#to_function_name(this_func) == "test_to_function_name"
	Assert chained#to_function_name("<SNR>313_any_func") == "any_func"
	Assert chained#to_function_name("function <SNR>313_any_func") == "any_func"
	Assert chained#to_function_name("<SNR>_any_func") == "<SNR>_any_func"
	Assert chained#to_function_name("g:any_func") == "g:any_func"
endfunction


function! g:test_function_symbol()
	Assert chained#function_symbol() == "g:test_function_symbol"
endfunction


function! s:test_function_symbol()
	Assert chained#function_symbol() == "<SNR>".s:SID()."_test_function_symbol"
	Assert chained#to_function_name(chained#function_symbol()) == "test_function_symbol"
	call g:test_function_symbol()
endfunction


function! s:test_to_SID()
	Assert chained#to_SID(expand("<sfile>")) == s:SID()
	Assert chained#to_SID(chained#function_symbol()) == s:SID()
	Assert chained#to_SID("<SNR>313_any_func") == 313
	Assert chained#to_SID("function <SNR>313_any_func") == 313
	Assert chained#to_SID("g:any_func") == ""
endfunction


function! g:test_SID()
	Assert chained#SID() == ""
endfunction

function! s:test_SID()
	Assert chained#SID() == s:SID()
	Assert chained#SID() == chained#to_SID(expand("<sfile>"))
	call g:test_SID()
endfunction


function! s:plus(a, b)
	return a:a + a:b
endfunction

function! g:plus(a, b)
	return a:a + a:b
endfunction

function! s:test_function()
	Assert chained#function("s:plus") == function("s:plus")
	Assert chained#function("g:plus") == function("g:plus")
endfunction


function! s:caller_test_all()
	call s:test_called_func()
	call s:test_to_function_name()
	call s:test_function_symbol()
	call s:test_SID()
	call s:test_function()
endfunction

function! g:caller_test_all()
	call s:caller_test_all()
endfunction




