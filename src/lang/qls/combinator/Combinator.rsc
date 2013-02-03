module lang::qls::combinator::Combinator

import IO;
import List;
import String;

import lang::ql::ast::AST;
import lang::ql::tests::ParseHelper;
import lang::qls::ast::AST;
import lang::qls::tests::ParseHelper;
import lang::qls::util::StyleHelpers;

public void main() {
  Form f = parseForm(|project://QL-R-kemi/forms/proposedSyntax.q|);
  Stylesheet s = parseStylesheet(|project://QL-R-kemi/stylesheets/proposedSyntax.qs|);
  //Stylesheet s = parseStylesheet("stylesheet S1 { section \"S1\" { section \"SS\" {question Q1 { type checkbox }} } section \"P1\" {  } }");
  //Stylesheet s = parseStylesheet("stylesheet S1 { question Q1 { type checkbox width 100 } default boolean { type radio } default string { width 104 }}");
  iprintln(getStyleRules("questionTen", f, s));
}
