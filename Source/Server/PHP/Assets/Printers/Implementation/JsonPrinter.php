<?php

namespace Assets\Printers\Implementation;

use Assets\Printers\Printers;

class JsonPrinter implements Printers
{
    public function printLine(array $arrayForPrint): void
    {
        $jsonResult = json_encode($arrayForPrint, JSON_NUMERIC_CHECK);
        if ($jsonResult !== false)
        {
            echo $jsonResult;
        }
        else
        {
            die('{"Status": "ERROR", "Message": "JSON encode failed"}');
        }
    }
}