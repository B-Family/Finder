<?php

namespace API;

use Assets\Database\QueryExecutor;
use Exceptions\Implementation\ParameterException;

class MethodContainer
{
    public function getHashesAmount(): array
    {
        $queryExecutor = new QueryExecutor();
        try
        {
            $queryResult = $queryExecutor->executeQuery("SELECT COUNT(*) AS HashesAmount FROM `hashes`");
        }
        finally
        {
            unset($queryExecutor);
        }
        return array('Status' => 'OK', 'Result' => 'Got amount of hashes', 'HashesAmount' => $queryResult['HashesAmount']);
    }
    public function decryptHash(string $hash): array
    {
        if (strlen($hash) == 32)
        {
            $queryExecutor = new QueryExecutor();
            try
            {
                $trio = substr($hash, 0, 3);
                $queryResult = $queryExecutor->executeQuery("SELECT `hashes`.`password` AS Password FROM `hashes` WHERE `hashes`.`trio` = '$trio' AND `hashes`.`hash` = '$hash'");
                if ($queryResult !== null)
                {
                    return array('Status' => 'OK', 'Result' => 'Password found', 'Password' => urldecode($queryResult['Password']));
                }
                else
                {
                    return array('Status' => 'OK', 'Result' => 'Password not found');
                }
            }
            finally
            {
                unset($queryExecutor);
            }
        }
        else
        {
            throw new ParameterException('Hash must be 32 characters long');
        }
    }
}