@license{
  Copyright (c) 2013 
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Kevin van der Vlist - kevin@kevinvandervlist.nl}
@contributor{Jimi van der Woning - Jimi.vanderWoning@student.uva.nl}

module lang::qls::compiler::web::CSS

import IO;
import lang::ql::ast::AST;
import lang::qls::ast::AST;
import lang::qls::util::StyleHelper;

public void CSS(Stylesheet sheet, loc dest) {
  dest += "style.css";
  
  writeFile(dest, CSS(sheet));
}

private str CSS(Stylesheet s) {
  f = getAccompanyingForm(s);
  typeMap = getTypeMap(f);

  ret = "";

  for(k <- typeMap) {
    rules = getStyleRules(k.ident, f, s);
    ret += "\n/* Question <k.ident> */";
    for(r <- rules) {
      ret += "<CSS(k.ident, r)>\n";
    }
  }

  return ret;
}

private str blockIdent(str ident) =
  "<ident>Block";

private str CSS(str ident, StyleRule r: 
    intStyleRule(StyleAttr attr, int \value)) =
  "#<ident> { width: <\value>px; }"
    when attr is width;

private str CSS(str ident, StyleRule r: 
    intStyleRule(StyleAttr attr, int \value)) =
  "#<blockIdent(ident)> *:not(:first-child) { font-size: <\value>px; }"
    when attr is fontsize;

private str CSS(str ident, StyleRule r: 
    intStyleRule(StyleAttr attr, int \value)) =
  "#<blockIdent(ident)> label:first-child { font-size: <\value>px; }"
    when attr is labelFontsize;

// Other intStyleRules are not implemented in CSS
private default str CSS(str ident, StyleRule r: 
    intStyleRule(StyleAttr attr, int \value)) =
  "";

private str CSS(str ident, StyleRule r: 
    stringStyleRule(StyleAttr attr, str \value)) =
  "#<blockIdent(ident)> *:not(:first-child) { font-family: <\value>; }"
    when attr is font;

private str CSS(str ident, StyleRule r: 
    stringStyleRule(StyleAttr attr, str \value)) =
  "#<blockIdent(ident)> label:first-child { font-family: <\value>; }"
    when attr is labelFont;

// Other stringStyleRules are not implemented in CSS
private str CSS(str ident, StyleRule r: 
    stringStyleRule(StyleAttr attr, str \value)) =
  "";

private str CSS(str ident, StyleRule r: 
    colorStyleRule(StyleAttr attr, str \value)) =
  "#<blockIdent(ident)> *:not(:first-child) { color: <\value>; }"
    when attr is color;

private str CSS(str ident, StyleRule r: 
    colorStyleRule(StyleAttr attr, str \value)) =
  "#<blockIdent(ident)> label:first-child { color: <\value>; }"
    when attr is labelColor;

// Other colorStyleRules are not implemented in CSS
private str CSS(str ident, StyleRule r: 
    colorStyleRule(StyleAttr attr, str \value)) =
  "";

// Other types of StyleRules are unimplemented in CSS
private str CSS(str ident, StyleRule r) =
  "";
