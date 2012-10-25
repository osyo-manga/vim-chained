let s:save_cpo = &cpo
set cpo&vim
scriptencoding utf-8


function! chained#call_stack()
	try
		throw 'abc'
	catch /^abc$/
		return split(matchstr(v:throwpoint, 'function \zs.*\ze,.*'), '\.\.')[ : -2]
	endtry
endfunction


function! chained#called_func(...)
	return get(chained#call_stack(), a:1 ? -2 + (a:1 * -1) : -2, "")
endfunction


function! chained#function_symbol()
	return chained#called_func(1)
endfunction


function! chained#to_function_name(symbol)
	let result = matchstr(a:symbol, '^.*<SNR>\d\+_\zs.*\ze$')
	return empty(result) ? a:symbol : result
endfunction


function! chained#to_SID(symbol)
	return matchstr(a:symbol, '^.*<SNR>\zs\d\+\ze_.*$')
endfunction


function! chained#to_SNR(symbol)
	return matchstr(a:symbol, '^.*\zs<SNR>\d\+_\ze.*$')
endfunction


function! chained#SID()
	return chained#to_SID(chained#called_func(1))
endfunction


function! chained#SNR()
	return chained#to_SNR(chained#called_func(1))
endfunction


function! chained#function_name()
	return chained#to_function_name(chained#called_func(1))
endfunction


function! chained#this_func()
	return chained#called_func(1)
endfunction


function! chained#function(name)
	let SNR = chained#to_SNR(chained#called_func(1))
	let funcname = substitute(a:name, "s:", SNR, "g")
	return function(funcname)
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
