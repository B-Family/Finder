<?php

namespace Exceptions\Implementation;

use Exception;
use Exceptions\NormalizedCauserFileNameExceptions;
use Utilities\Grinders\StringGrinder;

final class ParameterException extends Exception implements NormalizedCauserFileNameExceptions
{
    public function getCauserFileName(): string
    {
        $charEntry = StringGrinder::strLastPosArray($this->file, array('/', '\\'));
        return substr($this->file, $charEntry + 1, strlen($this->file) - ($charEntry + 1));
    }
}