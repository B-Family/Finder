<?php

namespace Assets\Printers;

interface Printers
{
    public function printLine(array $arrayForPrint): void;
}