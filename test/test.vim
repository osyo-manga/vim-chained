
function! s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun


function! s:test_called_func2(called)
	OwlCheck chained#called_func(0) == chained#function_symbol()
	OwlCheck chained#called_func(1) == a:called
	OwlCheck chained#called_func(100) == ""
endfunction


function! s:test_called_func()
	OwlCheck chained#called_func(0) == chained#function_symbol()
	call s:test_called_func2(chained#called_func(0))
endfunction



function! s:test_to_function_name()
	let this_func = expand("<sfile>")
	OwlCheck chained#to_function_name(this_func) == "test_to_function_name"
	OwlCheck chained#to_function_name("<SNR>313_any_func") == "any_func"
	OwlCheck chained#to_function_name("function <SNR>313_any_func") == "any_func"
	OwlCheck chained#to_function_name("<SNR>_any_func") == "<SNR>_any_func"
	OwlCheck chained#to_function_name("g:any_func") == "g:any_func"
endfunction


function! g:test_function_symbol()
	OwlCheck chained#function_symbol() == "g:test_function_symbol"
endfunction


function! s:test_function_symbol()
	let SNR = "<SNR>".s:SID()."_test_function_symbol"
	OwlCheck chained#function_symbol() == SNR
	OwlCheck chained#to_function_name(chained#function_symbol()) == "test_function_symbol"
	call g:test_function_symbol()
endfunction


function! s:test_to_function_symbol()
	OwlCheck chained#to_function_symbol("s:test_to_function_symbol") == chained#this_func()
	OwlCheck chained#to_function_symbol("s:func") == chained#SNR() . "func"
	OwlCheck chained#to_function_symbol("s:func", 123) == "<SNR>123_func"
endfunction


function! s:test_to_SID()
	OwlCheck chained#to_SID(expand("<sfile>")) == s:SID()
	OwlCheck chained#to_SID(chained#function_symbol()) == s:SID()
	OwlCheck chained#to_SID("<SNR>313_any_func") == 313
	OwlCheck chained#to_SID("function <SNR>313_any_func") == 313
	OwlCheck chained#to_SID("g:any_func") == ""
endfunction


function! g:test_SID()
	OwlCheck chained#SID() == ""
endfunction

function! s:test_SID()
	OwlCheck chained#SID() == s:SID()
	OwlCheck chained#SID() == chained#to_SID(expand("<sfile>"))
	call g:test_SID()
endfunction


function! s:test_to_SNR()
	OwlCheck chained#to_SNR(expand("<sfile>")) == "<SNR>" . s:SID() . "_"
	OwlCheck chained#to_SNR(chained#function_symbol()) == "<SNR>" . s:SID() . "_"
	OwlCheck chained#to_SNR("<SNR>313_any_func") == "<SNR>313_"
	OwlCheck chained#to_SNR("function <SNR>313_any_func") == "<SNR>313_"
	OwlCheck chained#to_SNR("g:any_func") == ""
endfunction


function! s:test_SNR()
	OwlCheck chained#SNR() == chained#to_SNR(expand("<sfile>"))
	OwlCheck chained#SNR() == "<SNR>" . s:SID() . "_"
	OwlCheck chained#SNR() == chained#to_SNR(chained#function_symbol())
endfunction


function! Test_this_func()
	OwlCheck chained#this_func() == "Test_this_func"
endfunction

function! g:test_this_func()
	OwlCheck chained#this_func() == "g:test_this_func"
endfunction

function! s:test_this_func()
	let SNR = chained#SNR()
	OwlCheck chained#this_func() == SNR."test_this_func"
	OwlCheck chained#to_function_name(chained#this_func()) == "test_this_func"
	call Test_this_func()
	call g:test_this_func()
endfunction


function! s:test_is_function_symbol()
	OwlCheck  chained#is_function_symbol("<SNR>123_func")
	OwlCheck !chained#is_function_symbol("<SNR>123func")
	OwlCheck !chained#is_function_symbol("<SID>123func")
	OwlCheck !chained#is_function_symbol("s:func")
	OwlCheck !chained#is_function_symbol("g:func")
endfunction



function! s:plus(a, b)
	return a:a + a:b
endfunction

function! g:plus(a, b)
	return a:a + a:b
endfunction

function! Test_function_test(funcname)
	return function(a:funcname)
endfunction

function! s:test_function()
" 	OwlCheck chained#function("s:plus") == function("s:plus")
	OwlCheck chained#function("s:plus")(1, 2) == function("s:plus")(1, 2)
	OwlCheck chained#function("g:plus") == function("g:plus")
	OwlCheck Test_function_test("s:plus")(1, 2) == chained#function("s:plus")(1, 2)
endfunction



function! s:Test_call_stack_func2(funcname)
	
endfunction

function! Test_call_stack_func1(funcname)

endfunction

function! s:test_call_stack()
" 	echo chained#call_stack()
" 	echo chained#this_func()
	OwlCheck chained#call_stack()[ -1 ] == chained#this_func()
endfunction


function! s:test_latest_called_script_function()
	OwlCheck chained#this_func() == chained#latest_called_script_function()

	let stack = ['<SNR>346_test_latest_called_script_function', '<SNR>346_func', 'chained#latest_called_script_function', 'g:func']
	OwlCheck '<SNR>346_func' == chained#latest_called_script_function(stack)
endfunction



function! s:test_script_function_to_function_symbol()
	echo chained#script_function_to_function_symbol("s:func()", "<SNR>123_")
	OwlCheck chained#script_function_to_function_symbol("s:func()", "<SNR>123_") == "<SNR>123_func()"
	OwlCheck chained#script_function_to_function_symbol("s:homu", "<SNR>123_") == "s:homu"
	let tmp = "s:homu()s:func()"
	OwlCheck chained#script_function_to_function_symbol(tmp, "<SNR>123_") == "<SNR>123_homu()<SNR>123_func()"
endfunction

OwlCheck !chained#is_function_cope()

function! s:test_is_function_scope()
	OwlCheck chained#is_function_cope()
endfunction


function! s:caller_test_all()
	call s:test_called_func()
	call s:test_to_function_name()
	call s:test_function_symbol()
	call s:test_to_function_symbol()
	call s:test_SID()
	call s:test_to_SID()
	call s:test_SNR()
	call s:test_to_SNR()
	call s:test_this_func()
	call s:test_function()
	call s:test_call_stack()
	call s:test_is_function_symbol()
	call s:test_latest_called_script_function()
	call s:test_script_function_to_function_symbol()
endfunction

function! g:caller_test_all()
	call s:caller_test_all()
endfunction





