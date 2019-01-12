<?php

namespace Utilities\Grinders;

class StringGrinder
{
    public static function strFirstPosArray(string $haystack, array $needleArray): ?int
    {
        $posArray = [];
        foreach ($needleArray as $needleChar)
        {
            $result = strpos($haystack, $needleChar);
            if ($result !== false)
            {
                $posArray[] = $result;
            }
        }
        if (count($posArray) > 1)
        {
            return min($posArray);
        }
        elseif (count($posArray) == 1)
        {
            return $posArray[0];
        }
        else
        {
            return null;
        }
    }
    public static function strLastPosArray(string $haystack, array $needleArray): ?int
    {
        $posArray = [];
        foreach ($needleArray as $needleChar)
        {
            $result = strrpos($haystack, $needleChar);
            if ($result !== false)
            {
                $posArray[] = $result;
            }
        }
        if (count($posArray) > 1)
        {
            return max($posArray);
        }
        elseif (count($posArray) == 1)
        {
            return $posArray[0];
        }
        else
        {
            return null;
        }
    }
}