<?php

namespace Utilities\System;

class DirectoryResolver
{
    public static function getPhpRootDirectory(): string
    {
        return $_SERVER['DOCUMENT_ROOT'] . '/PHP/';
    }
    public static function getIniRootDirectory(): string
    {
        return $_SERVER['DOCUMENT_ROOT'] . '/INI/';
    }
}