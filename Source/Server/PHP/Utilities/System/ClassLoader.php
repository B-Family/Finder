<?php

namespace Utilities\System;

final class ClassLoader
{
    public static function loadClass(string $className): void
    {
        $patchToFile = DirectoryResolver::getPhpRootDirectory() . str_replace('\\', '/', $className) . '.php';
        if (file_exists($patchToFile) === true)
        {
            require_once($patchToFile);
        }
        else
        {
            die('{"Status": "ERROR", "Message": "Target class file not found"}');
        }
    }
}