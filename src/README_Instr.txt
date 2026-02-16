MiniC Lexer Startup

This is a simple guide to help you compile and run the MiniC lexer program on the hamming computer in the SUN lab.
	
Instructions

1. Open your terminal.

2. Navigate to the source code directory of the project by using the cd command. For example:

	cd /home/dqp5476/Desktop/proj2-minic-lexer-startup/src

3. Run the following command to generate the Java lexer code from the Flex specification file (Lexer.flex) using JFlex 1.6.1:

	java -jar jflex-1.6.1.jar Lexer.flex

4. Compile the Java source files using the javac command. You can use the wildcard *.java to compile all Java files in the directory:

	javac *.java

5. Once the compilation is successful, you can execute the MiniC tokenizer program for each test file by running the following command, replacing test1.minc, test2.minc, ..., test6.minc, and testpreproc.minc with the respective MiniC source files you want to tokenize:

	java Program test1.minc
	java Program test2.minc
	java Program test3.minc
	java Program test4.minc
	java Program test5.minc
	java Program test6.minc
	java Program testpreproc.minc

Additional Information:
- Use jflex-1.6.1 to generate lexer code.
