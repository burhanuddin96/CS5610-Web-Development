defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  #Main Function
  def main do
    exp = IO.gets "Enter expression: "
    answer = eval(exp)
    IO.puts answer
    main()
  end

  #Function to evaluate expressions.
  def eval(expression) do
   
    valStack=[] #Stack to store all operands.
    opStack=[]  #Stack to store all operators.

    expression
      |>Utilities.get_spaced_exp()  #Format the expression with spaces
      |>String.split()              #Tokenize the expression
      |>parse_exp(valStack,opStack) #Evaluate expression
  end

  #Function to parse the expression.
  def parse_exp(tokens, valStack, opStack) do
    cond do
      #All tokens are parsed.
      (tokens == []) -> 
        eval_remaining_values(tokens, valStack, opStack)

      #Operand is encountered in expression
      Utilities.is_operand?(hd tokens) ->
        handle_operands(tokens, valStack, opStack)

      #Open paranthesis is encountered in expression
      Utilities.is_oparen?(hd tokens) ->
        handle_oparen(tokens, valStack, opStack)

      #Closed paranthesis is encountered in expression
      Utilities.is_cparen?(hd tokens) ->
        handle_cparen(tokens, valStack, opStack)

      #Operator is encountered in expression
      Utilities.is_operator?(hd tokens) ->
        handle_operators(tokens, valStack, opStack)
    end

  end

  #Function to evaluate remaining values in valStack after all tokens have been parsed.
  def eval_remaining_values(tokens, valStack, opStack) do
    if(opStack != []) do
      {oper, opStack} = Stack.pop(opStack)
      {op1, valStack} = Stack.pop(valStack)
      {op2, valStack} = Stack.pop(valStack)
      valStack = Stack.push(valStack, operate(oper, op2, op1))
      eval_remaining_values(tokens, valStack, opStack)    
    
    else
      {ans, valStack} = Stack.pop(valStack)
      ans

    end
  end

  #Function to handle all operands in the expression.
  defp handle_operands(tokens, valStack, opStack) do
    [first | restTokens] = tokens
    valStack = Stack.push(valStack, elem(Float.parse(first),0))
    parse_exp(restTokens, valStack, opStack)
  end

  #Function to handle all open paranthesis in the expression.
  defp handle_oparen(tokens, valStack, opStack) do
    [first | restTokens] = tokens
    opStack = Stack.push(opStack, first)
    parse_exp(restTokens, valStack, opStack)
  end

  #Function to handle all closed parenthesis in the expression.
  defp handle_cparen(tokens, valStack, opStack) do
    #Loops until open paranthesis is encountered in the opStack.
    if(Stack.peek(opStack) != "(") do
      {oper, opStack} = Stack.pop(opStack)
      {op1, valStack} = Stack.pop(valStack)
      {op2, valStack} = Stack.pop(valStack)
      valStack = Stack.push(valStack, operate(oper, op2, op1))
      handle_cparen(tokens, valStack, opStack)
    
    else
      restTokens = List.delete_at(tokens,0)
      {oper, opStack} = Stack.pop(opStack)
      parse_exp(restTokens, valStack, opStack)

    end
  end

  #Function to handle all operators in the expression
  defp handle_operators(tokens, valStack, opStack) do
    #Evaluates expression after checking for operator precedence and opStack.
    if(opStack != [] and Utilities.precedence((hd tokens), Stack.peek(opStack))) do
      {oper, opStack} = Stack.pop(opStack)
      {op1, valStack} = Stack.pop(valStack)
      {op2, valStack} = Stack.pop(valStack)
      valStack = Stack.push(valStack, operate(oper, op2, op1))
      handle_operators(tokens, valStack, opStack)
  
     else
      [first | restTokens] = tokens
      opStack = Stack.push(opStack, first)   
      parse_exp(restTokens, valStack, opStack)
    end
  end


  #Function defines what operation is to be performed.
  defp operate(operator, op1, op2) do
    case operator do
      "+" -> op1+op2
      "-" -> op1-op2
      "*" -> op1*op2
      "/" -> if op2 == 0 do
              raise ArgumentError, message: "Cannot divide by zero."
            else
              op1/op2
            end
    end
  end

end


#Module to define some utilities used in the calc module.
defmodule Utilities do
  
  #Returns true if token is operator
  def is_operator?(op) do
    (op == "+" or op == "-" or op == "*" or op == "/")
  end

  #Returns true if token is open parenthesis.
  def is_oparen?(op) do
    (op == "(")
  end

  #Returns true if token is closed parenthesis.
  def is_cparen?(op) do
    (op == ")")
  end

  #Returns true if token is operand.
  def is_operand?(op) do
    num = Float.parse(op)
    (num != :error)
  end

  #Function formats the expression with single space between each token.
  def get_spaced_exp(exp) do
    exp = Regex.replace(~r[\+], exp, " + ")
    exp = Regex.replace(~r[\-], exp, " - ")
    exp = Regex.replace(~r[\*], exp, " * ")
    exp = Regex.replace(~r[\/], exp, " / ")
    exp = Regex.replace(~r[\(], exp, " ( ")
    exp = Regex.replace(~r[\)], exp, " ) ")
    
    exp = Regex.replace(~r[\s+], exp, " ")
    exp
  end

  #Returns true iff oper2 has equal or high precedence than oper1
  #oper1 is the current token - operator.
  #oper2 is the top operator in the opStack
  def precedence(oper1, oper2) do
    cond do
      (oper2 == "(" or oper2 == ")") -> false
      ((oper2 == "+" or oper2 == "-") and (oper1 == "/" or oper1 == "*")) -> false
      true -> true
    end
  end
end


#Module to implement Stack Functionalities.
#Stack module code referred from "https://blog.codeship.com/statefulness-in-elixir/"
defmodule Stack do
  
  def push(stack, item) do
    [item | stack]
  end

  def pop(stack) do
    [top | rest] = stack
    {top, rest}
  end
  
  def peek(stack) do
    hd stack
  end
end