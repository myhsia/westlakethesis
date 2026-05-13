--[==========================================[--
        L3BUILD FILE FOR WESTLAKETHESIS
      Once Pushed With This File Modified
        A New Release Will Be Published
--]==========================================]--

--[==========================================[--
               Basic Information
             Do Check Before Push
--]==========================================]--

module              = "westlakethesis"
version             = "v0.0.1"
date                = "2026-05-20"
maintainer          = "Mingyu Xia"
uploader            = "Mingyu Xia"
maintainid          = "myhsia"
email               = "myhsia@outlook.com"
repository          = "https://github.com/" .. maintainid .. "/" .. module
summary             = "LaTeX bundle for Westlake University dissertations."
description         = "The `WestlakeThesis` is a LaTeX bundle for Westlake University dissertations, including Ph.D. thesis and Beamer theme."

--[==========================================[--
          Build, Pack, Tag, and Upload
         Do not Modify Unless Necessary
--]==========================================]--

checkengines        = {"xetex", "uptex", "luatex"}
ctanzip             = module
cleanfiles          = {"*.log", "*.pdf", "*.zip", "*.curlopt"}
excludefiles        = {"*~"}
installfiles        = {"*.sty", "*.cls", "*.code.tex"}
textfiles           = {"README.md", "LICENSE", "*.lua"}
typesetdemofiles    = {module .. "-demo.tex"}
typesetexe          = "latexmk -pdfxe"
typesetruns         = 1
uploadconfig  = {
  announcement_file = "announcement.md",
  pkg               = module,
  version           = version .. " " .. date,
  author            = maintainer,
  uploader          = uploader,
  email             = email,
  summary           = summary,
  description       = description,
  license           = "lppl1.3c",  
  ctanPath          = "/macros/latex/contrib/" .. module,
  home              = "https://github.com/" .. maintainid,
  bugtracker        = repository .. "/issues",
  support           = repository .. "/issues",
  repository        = repository,
  development       = "https://github.com/" .. maintainid,
  update            = true
}
function update_tag(file, content, tagname, tagdate)
  tagname = version
  tagdate = date
  if string.match(file, "%.dtx$") then
    content = string.gsub(content,
      "\\def \\wlu@date    %{[^}]+%}",
      "\\def \\wlu@date    {" .. tagdate .. "}")
    content = string.gsub(content,
      "\\def \\wlu@version %{[^}]+%}",
      "\\def \\wlu@version {" .. tagname .. "}")
    content = string.gsub(content,
      "\\date{Released %d+%-%d+%-%d+\\quad \\texttt{v([%d%.A-Z]+)}}",
      "\\date{Released " .. tagdate .. "\\quad \\texttt{" .. tagname .. "}}")
  end
  return content
end

--[== "Hacks" to `l3build` | Do not Modify ==]--

function docinit_hook()
  cp(ctanreadme, unpackdir, currentdir)
  return 0
end
function tex(file,dir,cmd)
  dir = dir or "."
  cmd = cmd or typesetexe
  if os.getenv("WINDIR") ~= nil or os.getenv("COMSPEC") ~= nil then
    upretex_aux = "-usepretex=\"" .. typesetcmds .. "\""
    makeidx_aux = "-e \"$makeindex=q/makeindex -s " .. indexstyle .. " %O %S/\""
    sandbox_aux = "set \"TEXINPUTS=../unpacked;%TEXINPUTS%;\" &&"
  else
    upretex_aux = "-usepretex=\'" .. typesetcmds .. "\'"
    makeidx_aux = "-e \'$makeindex=q/makeindex -s " .. indexstyle .. " %O %S/\'"
    sandbox_aux = "TEXINPUTS=\"../unpacked:$(kpsewhich -var-value=TEXINPUTS):\""
  end
  return run(dir, sandbox_aux .. " " .. cmd         .. " " ..
                  upretex_aux .. " " .. makeidx_aux .. " " .. file)
end