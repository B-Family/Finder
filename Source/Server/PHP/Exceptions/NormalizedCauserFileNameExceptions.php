<?php

namespace Exceptions;

interface NormalizedCauserFileNameExceptions
{
    public function getCauserFileName(): string;
}