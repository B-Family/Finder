<?php

namespace Utilities\System;

use Exceptions\Implementation\IniFileException;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;

final class IniFileParser
{
    private static $instance;

    private $parsedIniFiles;

    public static function getInstance(): IniFileParser
    {
        if (self::$instance === null)
        {
            return (self::$instance = new self());
        }
        else
        {
            return self::$instance;
        }
    }

    public function getSpecifiedIniFile(string $iniFileName): array
    {
        $iniFileName = strtolower($iniFileName);
        if (array_key_exists($iniFileName, $this->parsedIniFiles) === true)
        {
            return $this->parsedIniFiles[$iniFileName];
        }
        else
        {
            throw new IniFileException('Such filename not found in list of .ini files');
        }
    }

    private function __construct()
    {
        $temporaryResultArray = [];
        $recursiveDirectoryIterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator(DirectoryResolver::getIniRootDirectory()));
        try
        {
            foreach ($recursiveDirectoryIterator as $iterationItem)
            {
                if (($iterationItem->isDir() === false) && (strtolower($iterationItem->getExtension()) == 'ini'))
                {
                    $parsedFileName = strtolower($iterationItem->getBasename('.ini'));
                    if (array_key_exists($parsedFileName, $temporaryResultArray) !== true)
                    {
                        $parsedFile = parse_ini_file(realpath($iterationItem->getPathname()), true, INI_SCANNER_TYPED);
                        if ($parsedFile !== false)
                        {
                            $temporaryResultArray[$parsedFileName] = $parsedFile;
                        }
                        else
                        {
                            throw new IniFileException('File ' . $iterationItem->getFilename() . ' was parsed with error');
                        }
                    }
                    else
                    {
                        throw new IniFileException('Duplicate filename entry');
                    }
                }
            }
            $this->parsedIniFiles = $temporaryResultArray;
        }
        finally
        {
            unset($recursiveDirectoryIterator);
        }
    }
}