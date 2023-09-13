import matplotlib.pyplot as plt

# Dados de tempo de execução para Python e Assembly
tempo_python = [0.036, 0.037, 0.045, 0.112, 0.371]
tempo_assembly = [0.003, 0.003, 0.004, 0.006, 0.028]

# Rótulos para as barras
rotulos_barras = ['Teste 1', 'Teste 2', 'Teste 3', 'Teste 4', 'Teste 5']

# Criar o gráfico
plt.figure(figsize=(10, 6))  # Define o tamanho da figura
plt.bar(rotulos_barras, tempo_python, label='Python')
plt.bar(rotulos_barras, tempo_assembly, label='Assembly', alpha=0.7)  # Adicione alpha para barras transparentes
plt.xlabel('Testes')
plt.ylabel('Tempo de Execução (s)')
plt.title('Comparação de Tempo de Execução entre Python e Assembly')
plt.legend()
plt.grid(axis='y', linestyle='--', alpha=0.7)

# Salvar o gráfico com alta qualidade
plt.savefig('grafico_tempo_execucao.png', dpi=300, bbox_inches='tight')

# Mostrar o gráfico
plt.show()
