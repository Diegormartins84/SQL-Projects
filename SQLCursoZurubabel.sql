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
/*
CREATE TABLE tb_Vendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdProduto INT NOT NULL,
	vlProduto DECIMAL(6,2) NOT NULL
);*/

CREATE TABLE tb_Vendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdCliente INT NOT NULL FOREIGN KEY REFERENCES tb_Clientes (cdCliente),
	dtVendas DATETIME NOT NULL
);

CREATE TABLE tb_ProdutoVenda(
	cdProdutoVenda INT PRIMARY KEY IDENTITY (1,1),
	cdVenda INT FOREIGN KEY REFERENCES tb_Vendas (cdVenda) NOT NULL,
	cdProduto INT FOREIGN KEY REFERENCES tb_Produtos (cdProduto) NOT NULL,
	qtProduto INT NOT NULL
)

-- FOREIGN KEY
-- CONSTRAINT

ALTER TABLE tb_Vendas
ADD CONSTRAINT FK_Produto_Vendas
FOREIGN KEY (cdProduto)
REFERENCES tb_Produtos(cdProduto)

/*
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
*/

-- Remover a tabela de vendas

-- DROP TABLE tb_Vendas

-- Inserindo novos produtos

-- SELECT * FROM tb_Produtos;
-- SELECT * FROM tb_Clientes;
-- SELECT * FROM tb_Vendas;
-- SELECT * FROM tb_ProdutoVenda;

-- INSERT INTO tb_ProdutoVenda VALUES (1, 1, 3) NAO FUNCIONA, BASES VAZIAS


-- 1 - Criar um cliente
/*
INSERT INTO tb_Clientes VALUES ('Paulo Guina', 
	'1980-05-01',
	'M',
	'Rua da Mecanica, 400',
	'Campinas',
	'São Paulo',
	'11 1234-5678',
	'11 912345678'
);
*/
-- 2 - Insert da venda
-- INSERT INTO tb_Vendas VALUES (1, GETDATE());
-- 3 - Insert da venda
-- INSERT INTO tb_ProdutoVenda VALUES (1, 1, 3);

/*
-- INNER JOIN
-- Soma dos valores dos produtos
SELECT * FROM tb_ProdutoVenda;

SELECT * FROM tb_Produtos;

-- Seleção dos dados com valores

SELECT * FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV
ON P.cdProduto = PV.cdProduto
/*
SELECT P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV
	ON P.cdProduto = PV.cdProduto
*/

SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente

SELECT C.nmCliente, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
--, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY C.nmCliente
*/
SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente

-- Soma dos valores
/*
SELECT C.nmCliente, SUM(PV.qtProduto) AS qtTotalProdutos, P.nmProduto, SUM(P.vlProduto*PV.qtProduto)
--, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY C.nmCliente, P.nmProduto
*/
SELECT C.nmCliente, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
--, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY C.nmCliente

-- Union ALL
-- Seleção dos dados com valores
/*
SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente

UNION ALL

SELECT V.cdVenda, C.nmCliente, NULL, 'Total produtos - Total vendas', SUM(PV.qtProduto) AS qtTotalProdutos, NULL, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY V.cdVenda, C.nmCliente
*/

SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto, TOTAL_VENDAS.qtTotalProdutos, TOTAL_VENDAS.qtValorTotalVenda
FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
INNER JOIN (
	SELECT V.cdVenda, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	GROUP BY V.cdVenda
	) AS TOTAL_VENDAS ON V.cdVenda = TOTAL_VENDAS.cdVenda
--WHERE V.cdCliente = 3
	;

/*
	-- Criando Stored Procedures
--Tem que ser a primeira função do lote
CREATE PROCEDURE sp_TotalVendasProdutosCliente(
	@cdCliente INT
)
AS 


SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto, TOTAL_VENDAS.qtTotalProdutos, TOTAL_VENDAS.qtValorTotalVenda
FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
INNER JOIN (
	SELECT V.cdVenda, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	GROUP BY V.cdVenda
	) AS TOTAL_VENDAS ON V.cdVenda = TOTAL_VENDAS.cdVenda
WHERE V.cdCliente = @cdCliente

-- sp_TotalVendasProdutosCliente 1
*/