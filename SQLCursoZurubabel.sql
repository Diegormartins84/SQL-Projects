/*
Nova base de dados
*/

CREATE DATABASE dbLojaJailson;

/*
Loja de Sucos do Jailson

* Vende sucos (principalmente de laranja).

* Dados dos clientes:
	Nome (texto)
	nascimento (data dd/mm/aa)
	sexo (número)
	endereço
		Rua(texto)
		cidade(texto)
		estado(texto)
	Telefones(texto)

* Dados das Vendas:
	Número da venda(número)
	cliente que comprou(texto)
	preço total(número)

* Dados do produto:
	Nome(texto)
	Preço(número)
*/


/*
Truncar - Diminui o tamanho do texto/dado

nmProduto VARCHAR(3);

"coxinha" (7 letras) -> Cox
*/

-- Aula 4 - Criando Base de Dados (parte 1)

CREATE TABLE tb_Produtos(
	cdProduto INT PRIMARY KEY IDENTITY(1,1),
	nmProduto VARCHAR(50) NOT NULL , --Obrigatório
	vlProduto DECIMAL(6, 2) NOT NULL
);

CREATE TABLE tb_Clientes(
	cdCliente INT PRIMARY KEY IDENTITY(1,1),
	nmCliente VARCHAR(50) NOT NULL,
	dtNascimento DATE,
	inSexo VARCHAR(1) NOT NULL,
	nmEndereco VARCHAR(50),
	nmCidade VARCHAR(50),
	nmEstado VARCHAR(30),
	nmTelefone VARCHAR(15),
	nmTelefone2 VARCHAR(15)
)

CREATE TABLE tb_Vendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdProduto INT NOT NULL,
	vlProduto DECIMAL(6,2) NOT NULL
);

-- FOREIGN KEY
-- CONSTRAINT

ALTER TABLE tb_Vendas
ADD CONSTRAINT FK_Produto_Vendas
FOREIGN KEY (cdProduto)
REFERENCES tb_Produtos(cdProduto)


-- Inserções das tabelas
--INSERT INTO [nome da tabela] ([colunas]) VALUES()

INSERT INTO tb_Produtos VALUES ('Suco de Laranja', 4.5);
-- Ordem errada
--INSERT INTO tb_Produtos VALUES (1.5, 'Suco de Manga')
-- Com os nomes das colunas
INSERT INTO tb_Produtos (vlProduto, nmProduto) VALUES (1.5, 'Suco de Manga')

-- Testando o CONSTRAINT

INSERT INTO tb_Vendas VALUES (4, 3.2)


-- Selecionando dados das tabelas
-- SELECT [Colunas] FROM [tabela]

SELECT cdProduto, nmProduto, vlProduto FROM tb_Produtos;
SELECT nmProduto, vlProduto, cdProduto FROM tb_Produtos;
SELECT cdProduto FROM tb_Produtos;
SELECT * FROM tb_Vendas;