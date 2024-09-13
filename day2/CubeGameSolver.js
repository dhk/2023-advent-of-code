import React, { useState } from 'react';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';

const CubeGameSolver = () => {
  const [inputData, setInputData] = useState('');
  const [result, setResult] = useState(null);
  const [error, setError] = useState(null);

  const isGamePossible = (game, maxRed, maxGreen, maxBlue) => {
    for (const subset of game) {
      if ((subset.red || 0) > maxRed || (subset.green || 0) > maxGreen || (subset.blue || 0) > maxBlue) {
        return false;
      }
    }
    return true;
  };

  const parseGame = (gameString) => {
    const [idPart, subsetsPart] = gameString.split(': ');
    const gameId = parseInt(idPart.split(' ')[1]);
    const subsets = subsetsPart.split('; ').map(subset => {
      const cubes = subset.split(', ');
      return cubes.reduce((acc, cube) => {
        const [count, color] = cube.split(' ');
        acc[color] = parseInt(count);
        return acc;
      }, {});
    });
    return [gameId, subsets];
  };

  const sumPossibleGameIds = (gamesData, maxRed, maxGreen, maxBlue) => {
    let totalSum = 0;
    const games = gamesData.trim().split('\n');
    for (const game of games) {
      const [gameId, parsedGame] = parseGame(game);
      if (isGamePossible(parsedGame, maxRed, maxGreen, maxBlue)) {
        totalSum += gameId;
      }
    }
    return totalSum;
  };

  const handleSolve = () => {
    try {
      const sum = sumPossibleGameIds(inputData, 12, 13, 14);
      setResult(sum);
      setError(null);
    } catch (err) {
      setError('Error processing input. Please check the format and try again.');
      setResult(null);
    }
  };

  return (
    <div className="p-4 max-w-2xl mx-auto">
      <h1 className="text-2xl font-bold mb-4">Cube Game Solver</h1>
      <textarea
        className="w-full h-40 p-2 border rounded mb-4"
        value={inputData}
        onChange={(e) => setInputData(e.target.value)}
        placeholder="Paste your game data here..."
      />
      <button
        className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        onClick={handleSolve}
      >
        Solve
      </button>
      {result !== null && (
        <Alert className="mt-4">
          <AlertTitle>Result</AlertTitle>
          <AlertDescription>
            Sum of IDs of possible games: {result}
          </AlertDescription>
        </Alert>
      )}
      {error && (
        <Alert className="mt-4" variant="destructive">
          <AlertTitle>Error</AlertTitle>
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}
    </div>
  );
};

export default CubeGameSolver;