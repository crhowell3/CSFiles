using System;
using System.Collections.Generic;
using System.Numerics;
using System.Text;

namespace Program2
{
    public class MinHeap
    {
        private List<Node> heap;
        public MinHeap()
        {
            heap = new List<Node>();
        }

        public void InsertNode(Node n)
        {
            heap.Add(n);

            int pos = heap.Count - 1;
            while (heap[pos].GetPriority() < heap[pos / 2].GetPriority())
            {
                NodeSwap(pos, pos / 2);
                pos /= 2;
            }
        }

        public Node ConsumeNode()
        {
            Node n = heap[0];
            heap[0] = heap[heap.Count - 1];
            heap.RemoveAt(heap.Count - 1);
            Heapify(0);
            return n;
        }

        public int GetSize()
        {
            return heap.Count;
        }

        public void NodeSwap(int pos_1, int pos_2)
        {
            Node temp;
            temp = heap[pos_1];
            heap[pos_1] = heap[pos_2];
            heap[pos_2] = temp;
        }

        public bool IsLeafNode(int position)
        {
            return position >= (heap.Count / 2) && position <= heap.Count;
        }

        public void Heapify(int position)
        {
            if (!IsLeafNode(position))
            {
                if (heap[position].GetPriority() > heap[position * 2].GetPriority()
                    || heap[position].GetPriority() > heap[position * 2 + 1].GetPriority()) {
                    if (heap[position * 2].GetPriority() < heap[position * 2 + 1].GetPriority())
                    {
                        NodeSwap(position, position * 2);
                        Heapify(position * 2);
                    } else
                    {
                        NodeSwap(position, position * 2 + 1);
                        Heapify(position * 2 + 1);
                    }
                }
            }
        }

        public void MakeHeap()
        {
            for (int i = (heap.Count / 2); i >= 1; i--)
            {
                Heapify(i);
            }
        }
    }
}
