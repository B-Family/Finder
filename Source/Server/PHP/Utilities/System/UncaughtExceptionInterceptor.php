<?php

namespace Utilities\System;

use Throwable;

final class UncaughtExceptionInterceptor
{
    public static function intercept(Throwable $exception)
    {
        die('{"Status": "ERROR", "Description": "' . $exception->getMessage() . '"}');
    }
}