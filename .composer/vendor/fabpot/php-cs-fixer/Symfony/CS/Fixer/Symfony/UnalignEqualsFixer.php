<?php

/*
 * This file is part of the PHP CS utility.
 *
 * (c) Fabien Potencier <fabien@symfony.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

namespace Symfony\CS\Fixer\Symfony;

use Symfony\CS\AbstractFixer;
use Symfony\CS\Tokenizer\Token;
use Symfony\CS\Tokenizer\Tokens;

/**
 * @author Dariusz Rumiński <dariusz.ruminski@gmail.com>
 */
class UnalignEqualsFixer extends AbstractFixer
{
    /**
     * {@inheritdoc}
     */
    public function getDescription()
    {
        return 'Unalign equals symbols.';
    }

    /**
     * {@inheritdoc}
     */
    public function fix(\SplFileInfo $file, $content)
    {
        $tokens = Tokens::fromCode($content);

        foreach ($tokens as $index => $token) {
            if (!$token->equals('=')) {
                continue;
            }

            $this->fixWhitespace($tokens[$index - 1]);
            $this->fixWhitespace($tokens[$index + 1]);
        }

        return $tokens->generateCode();
    }

    /**
     * If given token is a single line whitespace then fix it to be a single space.
     *
     * @param Token $token
     */
    private function fixWhitespace(Token $token)
    {
        if ($token->isWhitespace(array('whitespaces' => " \t"))) {
            $token->setContent(' ');
        }
    }
}
