"%windir%\system32\cmd.exe "/K" C:\Users\Kevin.Ryan\AppData\Local\mambaforge\Scripts\activate.bat C:\Users\Kevin.Ryan\AppData\Local\mambaforge
nmap <buffer> gx :!python %:p<CR>
nmap <buffer> gX :!start python %:p<CR>
map <buffer> <C-e> :w<CR> <bar> :!python %:p<CR>
map <buffer> <F8> :w<CR> <bar> :!start python %:p<CR>

iab <buffer> neqm if __name__ == "__main__"
iab <buffer> impl import matplotlib.pyplot as plt
iab <buffer> pL # pylint: disable
iab <buffer> bpt breakpoint()
iab <buffer> ipy from IPython import embed; embed()
