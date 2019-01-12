<?php

require_once($_SERVER['DOCUMENT_ROOT'] . '/PHP/Utilities/System/ClassLoader.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/PHP/Utilities/System/DirectoryResolver.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/PHP/Utilities/System/UncaughtExceptionInterceptor.php');

//error_reporting(0);
set_exception_handler('Utilities\System\UncaughtExceptionInterceptor::intercept');
spl_autoload_register('Utilities\System\ClassLoader::loadClass');