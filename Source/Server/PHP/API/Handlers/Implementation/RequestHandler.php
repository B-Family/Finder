<?php

namespace API\Handlers\Implementation;

use API\Handlers\Handlers;
use API\MethodContainer;
use Assets\Printers\Implementation\JsonPrinter;
use Exception;
use Exceptions\Implementation\RequestException;
use Exceptions\NormalizedCauserFileNameExceptions;
use ReflectionClass;

require_once($_SERVER['DOCUMENT_ROOT'] . '/PHP/GlobalSettings.php');

class RequestHandler implements Handlers
{
    private $validatedRequestParameters;

    private function validateRequestMethod(MethodContainer $targetObject, ?string $methodName): bool
    {
        if (preg_match('/^[a-zA-Z]+$/', $methodName) === 1)
        {
            return method_exists($targetObject, $methodName);
        }
        else
        {
            if (strlen($methodName) === 0)
            {
                throw new RequestException('Method name must be string, but null given');
            }
            else
            {
                throw new RequestException('Invalid characters in method name');
            }
        }
    }
    private function invokeRequestMethod(MethodContainer $targetObject, string $methodName, string $requestType): array
    {
        $reflectionClass = new ReflectionClass($targetObject);
        try
        {
            if (($reflectionClass->getMethod($methodName)->getNumberOfParameters() == 0) && ($requestType == 'GET'))
            {
                return call_user_func(array($targetObject, $methodName));
            }
            elseif (($reflectionClass->getMethod($methodName)->getNumberOfParameters() > 0) && ($requestType == 'POST'))
            {
                if ($this->validateRequestParameters($targetObject, $methodName) === true)
                {
                    return call_user_func_array(array($targetObject, $methodName), $this->validatedRequestParameters);
                }
                else
                {
                    throw new RequestException('Invalid request parameters');
                }
            }
            else
            {
                throw new RequestException('Invalid request type');
            }
        }
        finally
        {
            unset($reflectionClass);
        }
    }
    private function validateRequestParameters(MethodContainer $targetObject, string $methodName): bool
    {
        $postData = array_change_key_case(json_decode(file_get_contents('php://input'), true), CASE_LOWER);
        if ($postData !== null)
        {
            $reflectionClass = new ReflectionClass($targetObject);
            try
            {
                foreach ($reflectionClass->getMethod($methodName)->getParameters() as $parameter)
                {
                    if (array_key_exists(strtolower($parameter->name), $postData) === true)
                    {
                        $this->validatedRequestParameters[] = $postData[strtolower($parameter->name)];
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            finally
            {
                unset($reflectionClass);
            }
        }
        else
        {
            throw new RequestException('Post data must be JSON');
        }
        return true;
    }

    public function handle(): void
    {
        $methodName = array_change_key_case($_GET, CASE_LOWER)['method'];
        $jsonPrinter = new JsonPrinter();
        $methodContainer = new MethodContainer();
        try
        {
            if ($this->validateRequestMethod($methodContainer, $methodName) === true)
            {
                $jsonPrinter->printLine($this->invokeRequestMethod($methodContainer, $methodName, $_SERVER['REQUEST_METHOD']));
            }
            else
            {
                throw new RequestException('Unknown API method');
            }
        }
        catch (NormalizedCauserFileNameExceptions $exception)
        {
            $jsonPrinter->printLine(array('Status' => 'ERROR', 'Message' => $exception->getMessage(), 'File' => $exception->getCauserFileName(), 'Line' => $exception->getLine()));
        }
        catch (Exception $exception)
        {
            $jsonPrinter->printLine(array('Status' => 'ERROR', 'Message' => $exception->getMessage()));
        }
        finally
        {
            unset($jsonPrinter);
            unset($methodContainer);
        }
    }
}

(new RequestHandler())->handle();