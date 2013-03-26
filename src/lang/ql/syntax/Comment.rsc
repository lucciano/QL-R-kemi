@license{
  Copyright (c) 2013 
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Kevin van der Vlist - kevin@kevinvandervlist.nl}
@contributor{Jimi van der Woning - Jimi.vanderWoning@student.uva.nl}

module lang::ql::\syntax::Comment

extend lang::ql::\syntax::Expressions;

lexical Comment 
  = MultLine
  | @category="Comment" "//" ![\n]* $
  ;


lexical MultLine
  = @category="Comment" "/*" CommentChar* "*/"
  | StartComment Expr TailComment
  ;
  
lexical TailComment
  = MidComment TailComment
  | EndComment
  ;
  
lexical StartComment
  = @category="Comment" "/*" CommentChar* [\<]
  ;

lexical EndComment
  = @category="Comment" [\>] CommentChar* "*/"
  ;

lexical MidComment
  = @category="Comment" [\>] CommentChar* [\<]
  ;


lexical CommentChar
  = ![\<\>*]
  | [*] !>> [/]
  | [\\][\<\>]
  ;
  
  

