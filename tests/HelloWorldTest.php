<?php

use PHPUnit\Framework\TestCase;
use App\HelloWorld;

class HelloWorldTest extends TestCase
{
    public function testSayHelloReturnsCorrectString()
    {
        $helloWorld = new HelloWorld();
        $this->assertEquals('Hello, World!', $helloWorld->sayHello());
    }
}